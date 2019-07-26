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
	pu.obj_id as Name,
	overflow.fk_wastewater_node as FromNode, -- inlet is the waternode entering the pump
	overflow.fk_overflow_to as ToNode, -- outlet is the waternode at the top of next reach
	'default_qgep_pump_curve'::varchar as PumpCurve,
	'ON'::varchar as Status,
	pu.start_level as StartupDepth,
	pu.stop_level as ShutoffDepth,
	overflow.identifier as description,
	pu.obj_id::varchar as tag	
FROM qgep_od.pump pu
JOIN qgep_od.overflow overflow ON pu.obj_id::text = overflow.obj_id::text;
