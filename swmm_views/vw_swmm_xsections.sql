DROP VIEW IF EXISTS qgep_swmm.vw_xsections;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------

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
		WHEN re.clear_height = 0 THEN 100
		WHEN re.clear_height IS NULL THEN 100
		ELSE re.clear_height
	END as Geom1,
	0 as Geom2,
	0 as Geom3,
	0 as Geom4,
	1 as Barrels,
	NULL as Culvert
FROM qgep_od.reach re
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile 