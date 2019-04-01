DROP VIEW IF EXISTS qgep_swmm.vw_junctions;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_junctions AS

SELECT
	ma.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ma.identifier as description,
	concat(ma.remark, ',', wn.remark) as tag,
	wn.bottom_level as InvertElev,
	(co.level-wn.bottom_level) as MaxDepth
FROM qgep_od.vw_manhole as ma
LEFT JOIN qgep_od.vw_wastewater_node wn on fk_wastewater_structure = ma.obj_id
--LEFT JOIN qgep.cover co on ma.fk_main_cover = co.obj_id
LEFT JOIN qgep_od.vw_cover co on co.fk_wastewater_structure = ma.obj_id -- replace with line above when view manhole includes fk_main_cover
WHERE function != 4798 -- separating_structure -> used in swmm dividers
UNION ALL
SELECT
	ss.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ss.identifier as description,
	concat(ss.remark, ',', wn.remark) as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as MaxDepth
FROM qgep_od.vw_special_structure as ss
LEFT JOIN qgep_od.vw_wastewater_node wn on fk_wastewater_structure = ss.obj_id
--LEFT JOIN qgep.cover co on ma.fk_main_cover = co.obj_id
LEFT JOIN qgep_od.vw_cover co on co.fk_wastewater_structure = ss.obj_id -- replace with line above when view manhole includes fk_main_cover
WHERE function  != 4799 -- separating_structure -> used in swmm dividers

-----------------------------------
-- Default value for view
-----------------------------------
-- ALTER VIEW qgep_od.vw_cover ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','cover');
