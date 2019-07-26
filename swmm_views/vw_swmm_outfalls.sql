DROP VIEW IF EXISTS qgep_swmm.vw_outfalls;


--------
-- View for the swmm module class outfalls
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_outfalls AS

SELECT
	wn.obj_id as Name,
	coalesce(wn.bottom_level,0) as InvertElev,
	'FREE'::varchar as Type,
	NULL as StageData,
	'NO'::varchar as tide_gate,
	NULL::varchar as RouteTo,
	ws.identifier || ', ' || ws.remark as description,
	dp.obj_id::varchar as tag,
	wn.situation_geometry as geom
FROM qgep_od.discharge_point as dp
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = dp.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
WHERE wn.obj_id IS NOT NULL