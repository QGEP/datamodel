DROP VIEW IF EXISTS qgep_swmm.vw_outfalls;


--------
-- View for the swmm module class outfalls
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_outfalls AS

SELECT
	dp.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	dp.identifier as description,
	concat(dp.remark, ',', wn.remark) as tag,
	wn.bottom_level as invert_elev,
	'NO' as tide_gate
FROM qgep_od.vw_discharge_point as dp
LEFT JOIN qgep_od.vw_wastewater_node wn on fk_wastewater_structure = dp.obj_id


-----------------------------------
-- Default value for view
-----------------------------------
-- ALTER VIEW qgep_od.vw_cover ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','cover');