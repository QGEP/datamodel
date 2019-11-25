--------
-- View for the swmm module class xsections
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_xsections;

CREATE OR REPLACE VIEW qgep_swmm.vw_xsections AS

SELECT DISTINCT
  re.obj_id as Link,
  CASE
    WHEN pp.profile_type = 3350 THEN 'CIRCULAR'		-- circle
    WHEN pp.profile_type = 3353 THEN 'RECT_CLOSED'	-- rectangular
    WHEN pp.profile_type = 3351 THEN 'EGG'			-- egg
    WHEN pp.profile_type = 3355 THEN 'CUSTOM'		-- special
    WHEN pp.profile_type = 3352 THEN 'ARCH'			-- mouth
    WHEN pp.profile_type = 3354 THEN 'PARABOLIC'	-- open
    ELSE 'CIRCULAR'
  END as Shape,
  CASE
    WHEN re.clear_height = 0 THEN 0.1
    WHEN re.clear_height IS NULL THEN 0.1
    ELSE re.clear_height/1000 -- [mm] to [m]
  END as Geom1,
  0 as Geom2,
  0 as Geom3,
  0 as Geom4,
  1 as Barrels,
  NULL as Culvert
FROM qgep_od.reach re
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);
