DROP VIEW IF EXISTS qgep_swmm.vw_conduits;


--------
-- View for the swmm module class conduits
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_conduits AS

SELECT
	re.obj_id as name,
	rp_from.obj_id as inlet_node, -- is it the same as the junctions, dividers, outfalls, storages names?
	rp_to.obj_id as outlet_node,
	ne.identifier as description,
	ne.remark as tag,
	(rp_from.level-from_wn.bottom_level) as inlet_offset,
	(rp_to.level-to_wn.bottom_level) as outlet_offset,
	re.fk_pipe_profile as xsection,
	CASE
		WHEN ts.obj_id is not null THEN 'YES'
		ELSE 'NO' 
	END as flap_gate,
	re.length_effective as length,
	re.wall_roughness as roughness
FROM qgep_od.reach as re
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id::text = re.fk_reach_point_to::text
LEFT JOIN qgep_od.wastewater_node from_wn on from_wn.obj_id = rp_from.fk_wastewater_networkelement
LEFT JOIN qgep_od.wastewater_node to_wn on to_wn.obj_id = rp_to.fk_wastewater_networkelement
LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ws.obj_id::text
LEFT JOIN qgep_od.pipe_profile pp ON re.fk_pipe_profile::text = pp.obj_id::text
LEFT JOIN qgep_od.throttle_shut_off_unit ts ON ts.fk_wastewater_node = from_wn.obj_id  -- wastewater node of the downstream wastewater node
