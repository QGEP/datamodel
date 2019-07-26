DROP VIEW IF EXISTS qgep_swmm.vw_conduits;


--------
-- View for the swmm module class conduits
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_conduits AS

SELECT
	re.obj_id as Name,
	coalesce(from_wn.obj_id, 'default_qgep_node') as FromNode,
	coalesce(to_wn.obj_id, 'default_qgep_node') as ToNode,
	CASE 
		--WHEN re.length_effective <= 0.01 THEN st_length(progression_geometry)
		WHEN re.length_effective <= 0.01 AND st_length(progression_geometry) <= 0.01 THEN 0.01
		WHEN re.length_effective <= 0.01 AND st_length(progression_geometry) >= 0.01 THEN st_length(progression_geometry)
		WHEN re.length_effective IS NULL AND st_length(progression_geometry) <= 0.01 THEN 0.01
		WHEN re.length_effective IS NULL AND st_length(progression_geometry) >= 0.01 THEN st_length(progression_geometry)
		ELSE re.length_effective
	END as Length,
	coalesce(re.wall_roughness,0.01) as Roughness,
	coalesce((rp_from.level-from_wn.bottom_level),0) as InletOffset,
	coalesce((rp_to.level-to_wn.bottom_level),0) as OutletOffset,
	0 as InitFlow,
	0 as MaxFlow,
	ne.identifier || ', ' || ne.remark as description,
	ne.fk_wastewater_structure as tag,
	ST_Simplify(ST_CurveToLine(progression_geometry), 20, TRUE) as geom
FROM qgep_od.reach as re
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text

LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id::text = re.fk_reach_point_to::text

LEFT JOIN qgep_od.wastewater_node from_wn on from_wn.obj_id = rp_from.fk_wastewater_networkelement
LEFT JOIN qgep_od.wastewater_node to_wn on to_wn.obj_id = rp_to.fk_wastewater_networkelement
