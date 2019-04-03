DROP VIEW IF EXISTS qgep_swmm.vw_dividers;


--------
-- View for the swmm module class dividers
-- 20190329 qgep code sprint SB, TP
-- Question attribute Diverted Link: Name of link which receives the diverted flow. overflow > fk_overflow_to
 
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_dividers AS

SELECT
	ma.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ma.identifier as description,
	concat(ma.remark, ',', wn.remark) as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as max_depth,
	'???' as diverted_link
FROM 
	(
	-- recreate vw_manhole
	SELECT ma.obj_id, ws.identifier, ws.remark, fk_main_cover, function
	FROM qgep_od.manhole ma
    LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ma.obj_id::text
	) as ma
	
LEFT JOIN (
	-- recreate vw_wastewater_node
	SELECT fk_wastewater_structure, situation_geometry, remark, identifier, bottom_level
	FROM qgep_od.wastewater_node wn
    LEFT JOIN qgep_od.wastewater_networkelement we ON we.obj_id::text = wn.obj_id::text
	) as wn
on fk_wastewater_structure = ma.obj_id

LEFT JOIN qgep_od.cover co on ma.fk_main_cover = co.obj_id

WHERE function = 4798 -- separating_structure

UNION ALL

SELECT
	ss.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ss.identifier as description,
	concat(ss.remark, ',', wn.remark) as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as max_depth,
	'???' as diverted_link
FROM (
	-- recreate vw_special_structure
	SELECT ss.obj_id, ws.identifier, ws.remark, fk_main_cover, function
	FROM qgep_od.special_structure ss
    LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ss.obj_id::text
) as ss

LEFT JOIN (
	-- recreate vw_wastewater_node
	SELECT fk_wastewater_structure, situation_geometry, remark, identifier, bottom_level
	FROM qgep_od.wastewater_node wn
    LEFT JOIN qgep_od.wastewater_networkelement we ON we.obj_id::text = wn.obj_id::text
	) as wn 
on fk_wastewater_structure = ss.obj_id

LEFT JOIN qgep_od.cover co on ss.fk_main_cover = co.obj_id

WHERE function  = 4799 -- separating_structure
