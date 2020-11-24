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
	ws.identifier::text as description,
	cfh.value_en as tag,
	ST_SimplifyPreserveTopology(ST_CurveToLine(progression_geometry), 0.5)::geometry(LineStringZ, %(SRID)s)  as geom,
	CASE 
		WHEN status IN (7959, 6529, 6526) THEN 'planned'
		ELSE 'current'
	END as state
FROM qgep_od.reach as re
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id::text = re.fk_reach_point_to::text
LEFT JOIN qgep_od.wastewater_node from_wn on from_wn.obj_id = rp_from.fk_wastewater_networkelement
LEFT JOIN qgep_od.wastewater_node to_wn on to_wn.obj_id = rp_to.fk_wastewater_networkelement
LEFT JOIN qgep_od.channel ch on ch.obj_id::text = ws.obj_id::text
LEFT JOIN qgep_vl.channel_function_hydraulic cfh on cfh.code = ch.function_hydraulic
-- select only the primary channels pwwf.*
WHERE ch.function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
-- select only operationals and "planned"
AND status IN (6530, 6533, 8493, 6529, 6526, 7959);
-- 6526	"other.calculation_alternative"
-- 6529	"other.project"
-- 7959	"other.planned"
-- 6530	"operational.tentative"
-- 6533	"operational.will_be_suspended"
-- 8493	"operational"

-- 6532	"abanndoned.filled"
-- 3027	"unknown"
-- 3633	"inoperative"
-- 6523	"abanndoned.suspended_not_filled"
-- 6524	"abanndoned.suspended_unknown"
