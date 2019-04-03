DROP VIEW IF EXISTS qgep_swmm.vw_xsections;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_xsections AS

SELECT DISTINCT
	re.fk_pipe_profile as link,
	re.clear_height as max_depth,
	CASE
		WHEN pp.profile_type = 3350 THEN 'CIRCULAR'		-- circle
		WHEN pp.profile_type = 3353 THEN 'RECT_CLOSED'	-- rectangular
		WHEN pp.profile_type = 3351 THEN 'EGG'			-- egg
		WHEN pp.profile_type = 3355 THEN 'CUSTOM'		-- special
		WHEN pp.profile_type = 3352 THEN 'ARCH'			-- mouth
		WHEN pp.profile_type = 3354 THEN 'PARABOLIC'	-- open
		ELSE 'DUMMY' 									-- unknown
	END as shape 								
FROM qgep_od.reach re
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile 