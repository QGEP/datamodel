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
  ST_Simplify(ST_CurveToLine(perimeter_geometry), 5, TRUE)::geometry(LineString, %(SRID)s) as geom
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement we on we.obj_id = ca.fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments

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
DROP VIEW IF EXISTS qgep_swmm.vw_raingages;
CREATE OR REPLACE VIEW qgep_swmm.vw_raingages AS
SELECT
  ('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as Name,
  'INTENSITY'::varchar as Format,
  '0:15'::varchar as Interval,
  '1.0'::varchar as SCF,
  'TIMESERIES default_qgep_raingage_timeserie'::varchar as Source,
  st_centroid(perimeter_geometry)::geometry(Point, %(SRID)s) as geom
FROM qgep_od.catchment_area as ca
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL; -- to avoid unconnected catchments

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
