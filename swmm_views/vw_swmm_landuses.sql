


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------
-- create land uses
DROP VIEW IF EXISTS qgep_swmm.vw_landuses;
CREATE OR REPLACE VIEW qgep_swmm.vw_landuses AS


SELECT
	value_en as Name,
	0 as sweepingInterval,
	0 as fractionAvailable,
	0 as lastSwept

FROM qgep_vl.planning_zone_kind

