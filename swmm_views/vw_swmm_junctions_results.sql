DROP VIEW IF EXISTS qgep_swmm.vw_junctions_results;


--------
-- View for the swmm module class conduits
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_junctions_results AS

SELECT
	ju.*,
	nr.*
FROM qgep_swmm.junctions as ju
LEFT JOIN qgep_swmm.nodes_results nr ON ju.name = nr.id
