--------
-- View for the swmm module class xsections
-- 20190329 qgep code sprint SB, TP
--------
CREATE OR REPLACE VIEW qgep_swmm.vw_xsections AS

SELECT DISTINCT
  re.obj_id as Link,
  CASE
    WHEN pp.profile_type = 3350 THEN 'CIRCULAR'   -- circle
    WHEN pp.profile_type = 3353 THEN 'RECT_CLOSED'  -- rectangular
    WHEN pp.profile_type = 3351 THEN 'EGG'      -- egg
    WHEN pp.profile_type = 3355 THEN 'CUSTOM'   -- special
    WHEN pp.profile_type = 3352 THEN 'ARCH'     -- mouth
    WHEN pp.profile_type = 3354 THEN 'PARABOLIC'  -- open
    ELSE 'CIRCULAR'
  END as Shape,
  --ROMA: Geom1 = height -> used for all the profile types
  CASE
    WHEN re.clear_height = 0 THEN 0.1
    WHEN re.clear_height IS NULL THEN 0.1
    ELSE re.clear_height/1000::float -- [mm] to [m]
  END as Geom1,
  --ROMA: Geom2 = width -> needed for profile rect_closed,arch and parabolic
  CASE
    WHEN pp.profile_type IN (3352,3353,3354) THEN CASE
      WHEN pp.height_width_ratio IS NOT NULL THEN CASE
        WHEN re.clear_height = 0 THEN 0.1/pp.height_width_ratio
        WHEN re.clear_height IS NULL THEN 0.1/pp.height_width_ratio
        ELSE re.clear_height/1000::float/pp.height_width_ratio
      END
      WHEN pp.height_width_ratio IS NULL THEN 0.002  --ROMA: TODO default value for width to be set
      ELSE 0.002  --ROMA: TODO default value for width to be set
    END
    ELSE NULL
  END as Geom2,
  --ROMA: Geom3 = code -> used only for arch profile, but this code value is nowhere to be set in the QGEP model
  0 as Geom3,
  0 as Geom4,
  1 as Barrels,
  NULL as Culvert,
  CASE 
    WHEN status IN (7959, 6529, 6526) THEN 'planned'
    ELSE 'current'
  END as state,
  --ROMA: message give details about the profile type, height availability, width availability if needed and code availablitity if needed. To much details?
  CASE
    WHEN pp.profile_type = 3350 THEN CASE
      WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': circular profile with default value of 0.1m as clear_height')
      ELSE concat('Reach', re.obj_id,': circular profile with known clear_height value')
    END
    WHEN pp.profile_type = 3351 THEN CASE
      WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': egg profile with default value of 0.1m as clear_height')
      ELSE concat('Reach', re.obj_id,': egg profile with known clear_height value')
    END
    WHEN pp.profile_type = 3352 THEN CASE
      WHEN pp.height_width_ratio IS NOT NULL THEN CASE
        WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': arch profile with known height_width_ratio value and with default value of 0.1m as clear_height')
        ELSE concat('Reach', re.obj_id,': arch profile with known height_width_ratio value and with known clear_height value')
      END
      WHEN pp.height_width_ratio IS NULL THEN CASE
        WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': arch profile with default value of 1 as height_width_ratio and with default value of 0.1m as clear_height')
        ELSE concat('Reach', re.obj_id,': arch profile with default value of 1 as height_width_ratio and with known clear_height value')
      END
    END
    WHEN pp.profile_type = 3353 THEN CASE
      WHEN pp.height_width_ratio IS NOT NULL THEN CASE
        WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': rectangular profile with known height_width_ratio value and with default value of 0.1m as clear_height')
        ELSE concat('Reach', re.obj_id,': rectangular profile with known height_width_ratio value and with known clear_height value')
      END
      WHEN pp.height_width_ratio IS NULL THEN CASE
        WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': rectangular profile with default value of 1 as height_width_ratio and with default value of 0.1m as clear_height')
        ELSE concat('Reach', re.obj_id,': rectangular profile with default value of 1 as height_width_ratio and with known clear_height value')
      END
    END
    WHEN pp.profile_type = 3354 THEN CASE
      WHEN pp.height_width_ratio IS NOT NULL THEN CASE
        WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': parabolic profile with known height_width_ratio value, default value of 0.1m as clear_height and no code value')
        ELSE concat('Reach', re.obj_id,': parabolic profile with known height_width_ratio value, with known clear_height value and no code value')
      END
      WHEN pp.height_width_ratio IS NULL THEN CASE
        WHEN re.clear_height = 0 OR re.clear_height IS NULL THEN concat('Reach', re.obj_id,': parabolic profile with default value of 1 as height_width_ratio, with default value of 0.1m as clear_height and no code value')
        ELSE concat('Reach', re.obj_id,': parabolic profile with default value of 1 as height_width_ratio, with known clear_height value and no code value')
      END
    END
    WHEN pp.profile_type = 3355 THEN concat('Reach', re.obj_id,': custom profile to be defined in SWMM')
  END as message
FROM qgep_od.reach re
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ne.fk_wastewater_structure::text
LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ws.obj_id::text
WHERE ch.function_hierarchic = ANY (ARRAY[5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074]) 
-- select only operationals and "planned"
AND status IN (6530, 6533, 8493, 6529, 6526, 7959);