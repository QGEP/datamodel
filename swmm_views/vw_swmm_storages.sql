DROP VIEW IF EXISTS qgep_swmm.vw_storages;


--------
-- View for the swmm module class storages
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_storages AS

SELECT
	ss.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ss.identifier as description,
	concat(ss.remark, ',', wn.remark) as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as max_depth	
FROM qgep_od.vw_special_structure as ss
LEFT JOIN qgep_od.vw_wastewater_node wn on fk_wastewater_structure = ss.obj_id
LEFT JOIN qgep_od.vw_cover co on co.fk_wastewater_structure = ss.obj_id 
WHERE ss.function IS IN (
6397, --"pit_without_drain"
-- 245, --"drop_structure"
6398, --"hydrolizing_tank"
-- 5371, --"other"
-- 386, --"venting"
-- 3234, --"inverse_syphon_chamber"
-- 5091, --"syphon_head"
-- 6399, --"septic_tank_two_chambers"
3348, --"terrain_depression"
336, --"bolders_bedload_catchement_dam"
-- 5494, --"cesspit"
6478, --"septic_tank"
-- 2998, --"manhole"
-- 2768, --"oil_separator"
-- 246, --"pump_station"
3673, --"stormwater_tank_with_overflow"
3674, --"stormwater_tank_retaining_first_flush"
5574, --"stormwater_retaining_channel"
3675, --"stormwater_sedimentation_tank"
3676, --"stormwater_retention_tank"
5575, --"stormwater_retention_channel"
5576, --"stormwater_storage_channel"
3677, --"stormwater_composite_tank"
5372 --"stormwater_overflow"
-- 5373, --"floating_material_separator"
-- 383	, --"side_access"
-- 227, --"jetting_manhole"
-- 4799, --"separating_structure"
-- 3008, --"unknown"
-- 2745, --"vortex_manhole"
) -- is list of function OK?
UNION ALL
SELECT
	ii.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ws.identifier as description,
	concat(ws.remark, ',', wn.remark) as tag,
	wn.bottom_level as invert_elev,
	(ii.upper_elevation-wn.bottom_level) as max_depth	-- is upper_elevation OK?
	'YES' as seepage_loss -- voir capacité d'absoption dans QGEP l/s -> mm/h (besoin de surface utile pour calculer)
FROM qgep_od.infiltration_installation as ii
LEFT JOIN qgep_od.vw_wastewater_node wn on fk_wastewater_structure = ii.obj_id
LEFT JOIN qgep_od.wastewater_structure ws on ws.obj_id = ii.obj_id
WHERE ii.function IS IN (
)




-----------------------------------
-- Default value for view
-----------------------------------
-- ALTER VIEW qgep_od.vw_cover ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','cover');