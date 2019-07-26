DROP VIEW IF EXISTS qgep_swmm.vw_conduits_results;


--------
-- View for the swmm module class conduits
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_conduits_results AS

SELECT
	co.*,
	lr.*,
	xr.full_flow
FROM qgep_swmm.conduits as co
LEFT JOIN qgep_swmm.links_results lr ON co.name = lr.id
LEFT JOIN qgep_swmm.xsections_results xr ON co.name = xr.id
