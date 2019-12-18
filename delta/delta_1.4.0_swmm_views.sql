DROP SCHEMA IF EXISTS qgep_swmm CASCADE;
CREATE SCHEMA IF NOT EXISTS qgep_swmm;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_junctions;

CREATE OR REPLACE VIEW qgep_swmm.vw_junctions AS

-- manholes
SELECT
	wn.obj_id as Name,
	coalesce(wn.bottom_level,0) as InvertElev,
	(co.level-wn.bottom_level) as MaxDepth,
	NULL::float as InitDepth,
	NULL::float as SurchargeDepth,
	NULL::float as PondedArea,
	ws.identifier || ', ' || ws.remark as description,
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
	ws.identifier || ', ' || ws.remark as description,
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



--------
-- View for the swmm module class aquifiers
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_aquifiers;

CREATE OR REPLACE VIEW qgep_swmm.vw_aquifers AS

SELECT
	aq.obj_id as Name,
	0.5 as Porosity,
	0.15 as WiltingPoint,
	0.30 as FieldCapacity,
	5.0 as Conductivity,
	10.0 as ConductivitySlope,
	15.0 as TensionSlope,
	0.35 as UpperEvapFraction,
	14.0 as LowerEvapDepth,
	0.002 as LowerGWLossRate,
	minimal_groundwater_level as BottomElevation,
	average_groundwater_level as WaterTableElevation,
	0.3 as UnsatZoneMoisture,
	null as UpperEvapPattern
FROM qgep_od.aquifier as aq;



--------
-- View for the swmm module class conduits
-- 20190329 qgep code sprint SB, TP
--------

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
	ne.identifier || ', ' || ne.remark as description,
	ne.fk_wastewater_structure as tag,
	ST_Simplify(ST_CurveToLine(progression_geometry), 20, TRUE) as geom
FROM qgep_od.reach as re
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text

LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure

LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id::text = re.fk_reach_point_to::text

LEFT JOIN qgep_od.wastewater_node from_wn on from_wn.obj_id = rp_from.fk_wastewater_networkelement
LEFT JOIN qgep_od.wastewater_node to_wn on to_wn.obj_id = rp_to.fk_wastewater_networkelement

WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);



--------
-- View for the swmm module class dividers
-- 20190329 qgep code sprint SB, TP
-- Question attribute Diverted Link: Name of link which receives the diverted flow. overflow > fk_overflow_to

DROP VIEW IF EXISTS qgep_swmm.vw_dividers;

CREATE OR REPLACE VIEW qgep_swmm.vw_dividers AS

SELECT
	ma.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ws.identifier as description,
	'manhole' as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as max_depth,
	'???' as diverted_link
FROM qgep_od.manhole ma
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ma.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE function = 4798 -- separating_structure
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)

UNION ALL

SELECT
	ss.obj_id as Name,
	st_x(wn.situation_geometry) as X_coordinate,
	st_y(wn.situation_geometry) as Y_coordinate,
	ws.identifier as description,
	'special_stucture' as tag,
	wn.bottom_level as invert_elev,
	(co.level-wn.bottom_level) as max_depth,
	'???' as diverted_link
FROM qgep_od.special_structure ss
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ss.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE function  = 4799 -- separating_structure
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);



-------
-- View for the swmm module class landuses
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_landuses;

CREATE OR REPLACE VIEW qgep_swmm.vw_landuses AS
  SELECT
    value_en as Name,
    0 as sweepingInterval,
    0 as fractionAvailable,
    0 as lastSwept
  FROM qgep_vl.planning_zone_kind;



--------
-- View for the swmm module class losses
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_losses;

CREATE OR REPLACE VIEW qgep_swmm.vw_losses AS

SELECT DISTINCT
  re.obj_id as Link,
  0::float as Kentry,
  0::float as Kexit,
  0::float as Kavg,
  CASE
    WHEN ts.obj_id IS NOT NULL THEN 'YES'
    ELSE 'NO'
  END as flap_gate,
  0::float as Seepage
FROM qgep_od.reach re
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile
LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
LEFT JOIN qgep_od.wastewater_node from_wn on from_wn.obj_id = rp_from.fk_wastewater_networkelement
LEFT JOIN qgep_od.throttle_shut_off_unit ts ON ts.fk_wastewater_node = from_wn.obj_id;  -- wastewater node of the downstream wastewater node



--------
-- View for the swmm module class outfalls
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_outfalls;

CREATE OR REPLACE VIEW qgep_swmm.vw_outfalls AS

SELECT
  wn.obj_id as Name,
  coalesce(wn.bottom_level,0) as InvertElev,
  'FREE'::varchar as Type,
  NULL as StageData,
  'NO'::varchar as tide_gate,
  NULL::varchar as RouteTo,
  ws.identifier || ', ' || ws.remark as description,
  dp.obj_id::varchar as tag,
  wn.situation_geometry as geom
FROM qgep_od.discharge_point as dp
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = dp.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
WHERE wn.obj_id IS NOT NULL
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);



--------
-- View for the swmm module class subcatchments
-- 20190329 qgep code sprint SB, TP
--------
DROP VIEW IF EXISTS qgep_swmm.vw_subcatchments;

CREATE OR REPLACE VIEW qgep_swmm.vw_subcatchments AS

SELECT
  replace(ca.obj_id, ' ', '_') as Name,
  ('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as RainGage,
  coalesce(fk_wastewater_networkelement_rw_current, replace(ca.obj_id, ' ', '_')) as Outlet,
  CASE
    when surface_area is null then st_area(perimeter_geometry)
    when surface_area < 0.01 then st_area(perimeter_geometry)
    else surface_area
  END as Area,
  25 as percImperv,
  CASE
    WHEN wn.situation_geometry IS NOT NULL
    THEN 	
    (
    st_maxdistance(wn.situation_geometry, ST_ExteriorRing(perimeter_geometry))
    + st_distance(wn.situation_geometry, ST_ExteriorRing(perimeter_geometry))
    )/2
    ELSE
    (
    st_maxdistance(st_centroid(perimeter_geometry), ST_ExteriorRing(perimeter_geometry))
    + st_distance(st_centroid(perimeter_geometry), ST_ExteriorRing(perimeter_geometry))
    )/2
  END as Width, -- Width of overland flow path estimation
  0.5 as percSlope,
  0 as CurbLen,
  NULL as SnowPack,
  ca.identifier || ', ' || ca.remark as description,
  ca.obj_id as tag,
  ST_Simplify(ST_CurveToLine(perimeter_geometry), 5, TRUE) as geom
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement we on we.obj_id = ca.fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id;

-- Creates subarea related to the subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_subareas;

CREATE OR REPLACE VIEW qgep_swmm.vw_subareas AS
SELECT
  replace(ca.obj_id, ' ', '_') as Subcatchment,
  0.01 as NImperv,
  0.1 as NPerv,
  0.05 as SImperv,
  0.05 as SPerv,
  25 as PctZero,
  'OUTLET'::varchar as RouteTo,
  NULL::float as PctRouted,
  ca.identifier || ', ' || ca.remark as description,
  ca.obj_id::varchar as tag
FROM qgep_od.catchment_area as ca;

-- Creates a default raingage for each subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_raingages;

CREATE OR REPLACE VIEW qgep_swmm.vw_raingages AS
SELECT
  ('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as Name,
  'INTENSITY'::varchar as Format,
  '0:15'::varchar as Interval,
  '1.0'::varchar as SCF,
  'TIMESERIES default_qgep_raingage_timeserie'::varchar as Source,
  st_centroid(perimeter_geometry) as geom
FROM qgep_od.catchment_area as ca;

-- Creates default infiltration for each subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_infiltration;

CREATE OR REPLACE VIEW qgep_swmm.vw_infiltration AS
SELECT
  replace(ca.obj_id, ' ', '_')  as Subcatchment,
  3 as MaxRate,
  0.5 as MinRate,
  4 as Decay,
  7 as DryTime,
  0 as MaxInfil
FROM qgep_od.catchment_area as ca;


-- creates coverages
DROP VIEW IF EXISTS qgep_swmm.vw_coverages;

CREATE OR REPLACE VIEW qgep_swmm.vw_coverages AS
SELECT
  replace(ca.obj_id, ' ', '_')  as Subcatchment,
  pzk.value_en as landUse,
  round((st_area(st_intersection(ca.perimeter_geometry, pz.perimeter_geometry))/st_area(ca.perimeter_geometry))::numeric,2)*100 as percent
FROM qgep_od.catchment_area ca, qgep_od.planning_zone pz
LEFT JOIN qgep_vl.planning_zone_kind pzk on pz.kind = pzk.code
WHERE st_intersects(ca.perimeter_geometry, pz.perimeter_geometry)
AND st_isvalid(ca.perimeter_geometry) AND st_isvalid(pz.perimeter_geometry)
ORDER BY ca.obj_id, percent DESC;



--------
-- View for the swmm module class vertices
-- 20190329 qgep code sprint SB, TP
--------

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



--------
-- View for the swmm module class pumps
-- 20190329 qgep code sprint SB, TP
-- A pump in qgep is a node but a link in SWMM
-- -> The pump is attached to the reach which goes out from the pump
-- -> inlet node is the water node where the QGEP pump is located
-- -> outlet node is the water node at the end of the reach going out of the pump
--------

DROP VIEW IF EXISTS qgep_swmm.vw_pumps;

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
JOIN qgep_od.overflow overflow ON pu.obj_id::text = overflow.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = pu.obj_id::text
WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);



--------
-- View for the swmm module class polygons
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_polygons;

CREATE OR REPLACE VIEW qgep_swmm.vw_polygons AS

SELECT
  Subcatchment,
  round(ST_X((dp).geom)::numeric,2) as X_Coord,
  round(ST_Y((dp).geom)::numeric,2) as Y_Coord
  FROM (
    SELECT
      Name As Subcatchment,
      ST_DumpPoints(geom) AS dp,
      ST_NPoints(geom) as nvert
      FROM qgep_swmm.vw_subcatchments
    ) as foo
WHERE (dp).path[2] != nvert;	-- dont select last vertex



--------
-- View for the swmm module class storages
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_storages;

CREATE OR REPLACE VIEW qgep_swmm.vw_storages AS

SELECT
	wn.obj_id as Name,
	coalesce(wn.bottom_level,0) as InvertElev,
	coalesce((co.level-wn.bottom_level),0) as MaxDepth,
	0 as InitDepth,
	'FUNCTIONAL' as Shape,
	1000 as CurveCoefficientOrCurveName, -- curve coefficient if FONCTIONAL curve name if TABULAR
	0 as CurveExponent, -- if FONCTIONAL
	0 as CurveConstant, -- if FONCTIONAL
	0 as SurchargeDepth,
	0 as Fevap,
	NULL as Psi,
	NULL as Ksat, -- conductivity
	NULL as IMD,	
	ws.identifier || ', ' || ws.remark as description,
	ss.obj_id as tag,
	wn.situation_geometry as geom
FROM qgep_od.special_structure ss
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ss.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
LEFT JOIN qgep_od.cover co on ws.fk_main_cover = co.obj_id
WHERE ss.function IN ( -- must be the same list in vw_swmm_junctions
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
)
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
UNION ALL
SELECT
	wn.obj_id as Name,
	coalesce(wn.bottom_level,0) as InvertElev,
	coalesce((ii.upper_elevation-wn.bottom_level),0) as MaxDepth,
	0 as InitDepth,
	'FUNCTIONAL' as Shape,
	1000 as CurveCoefficientOrCurveName, -- curve coefficient if FONCTIONAL curve name if TABULAR
	0 as CurveExponent, -- if FONCTIONAL
	0 as CurveConstant, -- if FONCTIONAL
	0 as SurchargeDepth,
	0 as Fevap,
	NULL as Psi,
	(((absorption_capacity * 60 * 60) / 1000) / effective_area) * 1000 as Ksat, -- conductivity (liter/s * 60 * 60) -> liter/h, (liter/h / 1000)	-> m3/h,  (m/h *1000) -> mm/h
	NULL as IMD, 	
	--st_x(wn.situation_geometry) as X_coordinate,
	--st_y(wn.situation_geometry) as Y_coordinate,
	ws.identifier || ', ' || ws.remark as description,
	ii.obj_id as tag,
	wn.situation_geometry as geom
FROM qgep_od.infiltration_installation as ii
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ii.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement we ON we.fk_wastewater_structure::text = ws.obj_id::text
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
WHERE ii.kind IN (
--3282	--"with_soil_passage"
--3285	--"without_soil_passage"
--3279	--"surface_infiltration"
--277	--"gravel_formation"
--3284	--"combination_manhole_pipe"
--3281	--"swale_french_drain_infiltration"
--3087	--"unknown"
--3280	--"percolation_over_the_shoulder"
276		--"infiltration_basin"
--278	--"adsorbing_well"
--3283	--"infiltration_pipe_sections_gallery"
)
AND ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);



--------
-- View for the swmm module class xsections
-- 20190329 qgep code sprint SB, TP
--------

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
    ELSE re.clear_height/1000 -- [mm] to [m]
  END as Geom1,
  0 as Geom2,
  0 as Geom3,
  0 as Geom4,
  1 as Barrels,
  NULL as Culvert
FROM qgep_od.reach re
LEFT JOIN qgep_od.pipe_profile pp on pp.obj_id = re.fk_pipe_profile
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074);



--------
-- View for the swmm module class coordinates
-- 20190329 qgep code sprint SB, TP
--------

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



--------
-- View for the swmm module class tags
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_tags;

CREATE OR REPLACE VIEW qgep_swmm.vw_tags AS

SELECT
	'Node' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_junctions
WHERE tag IS NOT NULL

UNION

SELECT
	'Node' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_outfalls
WHERE tag IS NOT NULL

UNION

SELECT
	'Node' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_storages
WHERE tag IS NOT NULL

UNION

SELECT
	'Link' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_conduits
WHERE tag IS NOT NULL

UNION

SELECT
	'Link' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_pumps
WHERE tag IS NOT NULL

UNION

SELECT
	'Subcatch' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_subcatchments
WHERE tag IS NOT NULL;



