DROP VIEW IF EXISTS qgep_swmm.vw_junctions;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_junctions AS

-- manholes
SELECT
	ma.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ws.identifier as description,
	'manhole' as tag,
	wn.bottom_level as InvertElev,
	(co.level-wn.bottom_level) as MaxDepth
FROM qgep_od.manhole ma
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ma.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE function != 4798 -- separating_structure -> used in swmm dividers

UNION ALL

-- special structures
SELECT
	ss.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ws.identifier as description,
	'special_structure' as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as MaxDepth
FROM qgep_od.special_structure ss
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ss.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE function  != 4799 -- separating_structure -> used in swmm dividers
