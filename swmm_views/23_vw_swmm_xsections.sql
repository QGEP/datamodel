--------
-- View for the swmm module class xsections
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
  --Geom1 = height -> used for all the profile types
  CASE
    WHEN re.clear_height = 0 THEN 0.1
    WHEN re.clear_height IS NULL THEN 0.1
    ELSE re.clear_height/1000::float -- [mm] to [m]
  END as Geom1,
  --Geom2 = width -> needed for profile rect_closed,arch and parabolic
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
  --Geom3 = code -> used only for arch profile, but this code value is nowhere to be set in the QGEP model
  0 as Geom3,
  0 as Geom4,
  1 as Barrels,
  NULL as Culvert,
  CASE 
    WHEN status IN (7959, 6529, 6526) THEN 'planned'
    ELSE 'current'
  END as state,
  CASE 
		WHEN ch.function_hierarchic in (5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074) THEN 'primary'
		ELSE 'secondary'
	END as hierarchy,
  re.obj_id as obj_id,
  --message give details about the profile type, height availability, width availability if needed and code availablitity if needed. To much details?
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
WHERE status IN (6530, 6533, 8493, 6529, 6526, 7959);


UNION ALL

-- For the prank weir
SELECT
	pw.obj_id as Name,
  'RECT_OPEN' as Shape,
  (level_max - level_min) as Geom1,
  hydraulic_overflow_length as Geom2,
  NULL as Geom3,
  NULL as Geom4,
  NULL as Barrels,
  NULL as Culvert,
  CASE 
    WHEN status IN (7959, 6529, 6526) THEN 'planned'
    ELSE 'current'
  END as state
FROM qgep_od.prank_weir pw
LEFT JOIN qgep_od.overflow of ON pw.obj_id = of.obj_id
LEFT JOIN qgep_od.overflow_char oc ON of.fk_overflow_characteristic = oc.obj_id
LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id = of.fk_wastewater_node
LEFT JOIN qgep_od.wastewater_structure ws ON ws.fk_main_wastewater_node = wn.obj_id
WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
AND status IN (6530, 6533, 8493, 6529, 6526, 7959)
AND oc.overflow_characteristic_digital != 6223  --'NO or unknown;
OR oc.kind_overflow_characteristic != 6220 -- Q/Q relation or unknown
AND status IN (6530, 6533, 8493, 6529, 6526, 7959);

