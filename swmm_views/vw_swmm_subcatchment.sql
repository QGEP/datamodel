DROP VIEW IF EXISTS qgep_swmm.vw_subcatchment;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
-- A pump in qgep is a node but a link in SWMM
-- -> The pump is attached to the reach which goes out from the pump
-- -> inlet node is the water node where the QGEP pump is located
-- -> outlet node is the water node at the end of the reach going out of the pump
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_subcatchment AS

SELECT 
	ca.obj_id as Name,
	st_x(st_centroid(perimeter_geometry)) as X_coordinate,
	st_y(st_centroid(perimeter_geometry)) as Y_coordinate,
	ca.identifier as description,
	'catchment_area' as tag,
	fk_wastewater_networkelement_ww_current as outlet, -- name of node or another subcatchement that receives runoff
	surface_area as area
FROM qgep_od.catchment_area as ca
