DROP VIEW IF EXISTS qgep_swmm.vw_junctions CASCADE;

CREATE OR REPLACE VIEW qgep_swmm.vw_junctions AS

-- manholes
SELECT
	wn.obj_id as Name,
	coalesce(wn.bottom_level,0) as InvertElev,
	(co.level-wn.bottom_level) as MaxDepth,
	NULL::float as InitDepth,
	NULL::float as SurchargeDepth,
	NULL::float as PondedArea,
	ws.identifier::text  as description,
	ma.obj_id as tag,
	wn.situation_geometry as geom
FROM qgep_od.manhole ma
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ma.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE wn.obj_id IS NOT NULL
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
--AND function != 4798 -- separating_structure -> used in swmm dividers

UNION ALL

-- special structures
SELECT
	wn.obj_id as Name,
	coalesce(wn.bottom_level,0) as InvertElev,
	(co.level-wn.bottom_level) as MaxDepth,
	NULL::float as InitDepth,
	NULL::float as SurchargeDepth,
	NULL::float as PondedArea,
	ws.identifier::text  as description,
	ss.obj_id as tag,
	wn.situation_geometry as geom
FROM qgep_od.special_structure ss
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ss.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE wn.obj_id IS NOT NULL
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
--AND function != 4799 -- separating_structure -> used in swmm dividers
AND function NOT IN ( -- must be the same list in vw_swmm_storages
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
);

DROP VIEW IF EXISTS qgep_swmm.vw_conduits;

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
	ne.identifier::text  as description,
	ne.fk_wastewater_structure as tag,
	ST_Simplify(ST_CurveToLine(progression_geometry), 20, TRUE)::geometry(LineStringZ, %(SRID)s)  as geom
FROM qgep_od.reach as re
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text

LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure

LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id::text = re.fk_reach_point_to::text

LEFT JOIN qgep_od.wastewater_node from_wn on from_wn.obj_id = rp_from.fk_wastewater_networkelement
LEFT JOIN qgep_od.wastewater_node to_wn on to_wn.obj_id = rp_to.fk_wastewater_networkelement
LEFT JOIN qgep_od.channel ch on ch.obj_id::text = ws.obj_id::text
WHERE ch.function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);

DROP VIEW IF EXISTS qgep_swmm.vw_xsections;

CREATE OR REPLACE VIEW qgep_swmm.vw_xsections AS

SELECT DISTINCT
  re.obj_id as Link,
  CASE
    WHEN pp.profile_type = 3350 THEN 'CIRCULAR'		-- circle
    WHEN pp.profile_type = 3353 THEN 'RECT_CLOSED'	-- rectangular
    WHEN pp.profile_type = 3351 THEN 'EGG'			-- egg
    WHEN pp.profile_type = 3355 THEN 'CUSTOM'		-- special
    WHEN pp.profile_type = 3352 THEN 'ARCH'			-- mouth
    WHEN pp.profile_type = 3354 THEN 'PARABOLIC'	-- open
    ELSE 'CIRCULAR'
  END as Shape,
  CASE
    WHEN re.clear_height = 0 THEN 0.1
    WHEN re.clear_height IS NULL THEN 0.1
    ELSE re.clear_height/1000::float -- [mm] to [m]
  END as Geom1,
  0 as Geom2,
  0 as Geom3,
  0 as Geom4,
  1 as Barrels,
  NULL as Culvert
FROM qgep_od.reach re
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ne.fk_wastewater_structure::text
LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ws.obj_id::text
WHERE ch.function_hierarchic = ANY (ARRAY[5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074]);

DROP VIEW IF EXISTS qgep_swmm.vw_coordinates;

CREATE OR REPLACE VIEW qgep_swmm.vw_coordinates AS

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_junctions
WHERE geom IS NOT NULL

UNION

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_outfalls
WHERE geom IS NOT NULL

-- UNION

-- SELECT
	-- Name as Node,
	-- ROUND(ST_X(geom)::numeric,2) as X_Coord,
	-- ROUND(ST_Y(geom)::numeric,2) as Y_Coord		
-- FROM qgep_swmm.vw_dividers
-- WHERE geom IS NOT NULL

UNION

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_storages
WHERE geom IS NOT NULL

UNION

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_raingages
WHERE geom IS NOT NULL;

DROP VIEW IF EXISTS qgep_swmm.vw_vertices;

CREATE OR REPLACE VIEW qgep_swmm.vw_vertices AS

SELECT
  link,
  ROUND(ST_X((dp).geom)::numeric,2) as X_Coord,
  ROUND(ST_Y((dp).geom)::numeric,2) as Y_Coord
FROM (
  SELECT
    Name As Link,
    ST_DumpPoints(geom) AS dp,
    ST_NPoints(geom) as nvert
  FROM qgep_swmm.vw_conduits
  ) as foo
WHERE (dp).path[1] != 1		-- dont select first vertice
AND (dp).path[1] != nvert;	-- dont select last vertice