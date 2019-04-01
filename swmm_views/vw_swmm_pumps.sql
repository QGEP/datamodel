DROP VIEW IF EXISTS qgep_swmm.vw_pumps;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
-- A pump in qgep is a node but a link in SWMM
-- -> The pump is attached to the reach which goes out from the pump
-- -> inlet node is the water node where the QGEP pump is located
-- -> outlet node is the water node at the end of the reach going out of the pump
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_pumps AS

SELECT 
	pu.obj_id as name,
	pu.obj_id as inlet_node, -- inlet is the waternode entering the pump
	to_wn.obj_id as outlet_node, -- outlet is the waternode at the top of next reach
	start_level as startup_depth,
	stop_level as shutoff_depth,
	ws.identifier as description,
	ws.remark as tag
FROM qgep_od.pump as pu
LEFT JOIN qgep_od.wastewater_structure ws on pu.obj_id = ws.obj_id
LEFT JOIN qgep_od.wastewater_node wn on pu.obj_id = wn.obj_id
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = wn.obj_id
LEFT JOIN qgep_od.reach in_reach on in_reach.fk_reach_point_to = ne.obj_id
LEFT JOIN qgep_od.reach out_reach on out_reach.fk_reach_point_from = ne.obj_id
LEFT JOIN qgep_od.wastewater_node to_wn on to_wn.obj_id = out_reach.fk_reach_point_to
