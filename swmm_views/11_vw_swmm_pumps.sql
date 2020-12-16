--------
-- View for the swmm module class pumps
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
	pu.obj_id::varchar as tag,
	CASE 
		WHEN status IN (7959, 6529, 6526) THEN 'planned'
		ELSE 'current'
	END as state	
FROM qgep_od.pump pu
JOIN qgep_od.overflow overflow ON pu.obj_id::text = overflow.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = pu.obj_id::text
WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
AND status IN (6530, 6533, 8493, 6529, 6526, 7959);
