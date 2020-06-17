DROP VIEW IF EXISTS qgep_swmm.vw_subcatchments CASCADE;
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
  discharge_coefficient_rw_current as percImperv, -- take from catchment_area instead of default value
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
  0.5 as percSlope, -- default value
  0 as CurbLen, -- default value
  NULL::varchar as SnowPack, -- default value
  ca.identifier || ', ' || ca.remark as description,
  ca.obj_id as tag,
  ST_CurveToLine(perimeter_geometry) as geom
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement we on we.obj_id = ca.fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments

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

-- Creates subarea related to the subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_subareas;
CREATE OR REPLACE VIEW qgep_swmm.vw_subareas AS
SELECT
  replace(ca.obj_id, ' ', '_') as Subcatchment,
  0.01 as NImperv, -- default value, Manning's n for overland flow over the impervious portion of the subcatchment 
  0.1 as NPerv,-- default value, Manning's n for overland flow over the pervious portion of the subcatchment
  CASE
	WHEN sr.surface_storage IS NOT NULL THEN sr.surface_storage	
	ELSE 0.05 -- default value
  END as SImperv,-- Depth of depression storage on the impervious portion of the subcatchment (inches or millimeters)
    CASE
	WHEN sr.surface_storage IS NOT NULL THEN sr.surface_storage	
	ELSE 0.05 -- default value
  END as SPerv,-- Depth of depression storage on the pervious portion of the subcatchment (inches or millimeters)
  25 as PctZero,-- default value, Percent of the impervious area with no depression storage.
  'OUTLET'::varchar as RouteTo,
  NULL::float as PctRouted,
  ca.identifier || ', ' || ca.remark as description,
  ca.obj_id::varchar as tag
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.surface_runoff_parameters sr ON ca.obj_id = sr.fk_catchment_area
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments

-- Creates Dry Weather Flow related to the catchment area
DROP VIEW IF EXISTS qgep_swmm.vw_dwf;
CREATE OR REPLACE VIEW qgep_swmm.vw_dwf AS
SELECT
  fk_wastewater_networkelement_rw_current as Node, -- id of the junction
  'FLOW'::varchar as Constituent,
  CASE
	WHEN surface_area IS NOT NULL THEN population_density_current * surface_area * 160 / (24 * 60 * 60)
	ELSE population_density_current * ST_Area(perimeter_geometry) * 160 / (24 * 60 * 60)
  END as Baseline, -- 160 Litre / inhabitant /day
  'dailyPatternDWF'::varchar as Patterns
FROM qgep_od.catchment_area as ca
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments


-- Creates a default raingage for each subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_raingages CASCADE;
CREATE OR REPLACE VIEW qgep_swmm.vw_raingages AS
SELECT
  ('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as Name,
  'INTENSITY'::varchar as Format,
  '0:15'::varchar as Interval,
  '1.0'::varchar as SCF,
  'TIMESERIES default_qgep_raingage_timeserie'::varchar as Source,
  st_centroid(perimeter_geometry) as geom
FROM qgep_od.catchment_area as ca
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments

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
FROM qgep_od.catchment_area as ca
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments;

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
LEFT JOIN qgep_od.throttle_shut_off_unit ts ON ts.fk_wastewater_node = from_wn.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE ws._function_hierarchic in (5066, 5068, 5069, 5070, 5064, 5071, 5062, 5072, 5074)
;
