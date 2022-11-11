
--------
-- View for the swmm module class subcatchments
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_subcatchments AS
SELECT
  concat(replace(ca.obj_id, ' ', '_'), '_', state) as Name,
  concat('raingage@', replace(ca.obj_id, ' ', '_'))::varchar as RainGage,
  CASE
    WHEN state = 'rw_current' then fk_wastewater_networkelement_rw_current
    WHEN state = 'rw_planned'  then fk_wastewater_networkelement_rw_planned
    WHEN state = 'ww_current' then fk_wastewater_networkelement_ww_current
    WHEN state = 'ww_planned'  then fk_wastewater_networkelement_ww_planned
    ELSE replace(ca.obj_id, ' ', '_')
  END as Outlet,
  CASE
    when surface_area is null then st_area(perimeter_geometry)
    when surface_area < 0.01 then st_area(perimeter_geometry)
    else surface_area * 10000 -- conversion for ha to m2
  END as Area,
  CASE
    WHEN state = 'rw_current' then discharge_coefficient_rw_current
    WHEN state = 'rw_planned'  then discharge_coefficient_rw_planned
    WHEN state = 'ww_current' then discharge_coefficient_ww_current
    WHEN state = 'ww_planned'  then discharge_coefficient_ww_planned
    ELSE 0
  END as percImperv, -- take from catchment_area instead of default value
  CASE
    WHEN wn_geom IS NOT NULL
    THEN 	
    (
    st_maxdistance(wn_geom, ST_ExteriorRing(perimeter_geometry))
    + st_distance(wn_geom, ST_ExteriorRing(perimeter_geometry))
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
  CONCAT(ca.identifier, ', ', ca.remark) as description,
  ca.obj_id as tag,
  ST_SimplifyPreserveTopology(ST_CurveToLine(perimeter_geometry), 0.5)::geometry(Polygon, %(SRID)s) as geom,
  CASE
    WHEN state = 'rw_current' OR state = 'ww_current' THEN 'current'
    WHEN state = 'rw_planned' OR state = 'ww_planned' THEN 'planned'
    ELSE 'planned'
  END as state,
  CASE 
		WHEN _function_hierarchic in (5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074) THEN 'primary'
		ELSE 'secondary'
	END as hierarchy,
	wn_obj_id as obj_id
FROM (
  SELECT ca.*, wn.situation_geometry as wn_geom, 'rw_current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic FROM qgep_od.catchment_area as ca
  INNER JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = ca.fk_wastewater_networkelement_rw_current
  LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
  LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
  UNION ALL
  SELECT ca.*, wn.situation_geometry as wn_geom, 'rw_planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic FROM qgep_od.catchment_area as ca
  INNER JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = ca.fk_wastewater_networkelement_rw_planned
  LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
  LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
  UNION ALL
  SELECT ca.*, wn.situation_geometry as wn_geom, 'ww_current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic FROM qgep_od.catchment_area as ca
  INNER JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = ca.fk_wastewater_networkelement_ww_current
  LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
  LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
  UNION ALL
  SELECT ca.*, wn.situation_geometry as wn_geom,'ww_planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic FROM qgep_od.catchment_area as ca
  INNER JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = ca.fk_wastewater_networkelement_ww_planned
  LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
  LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
) as ca;


-- Creates subarea related to the subcatchment
CREATE OR REPLACE VIEW qgep_swmm.vw_subareas AS
SELECT
  concat(replace(ca.obj_id, ' ', '_'), '_', state) as Subcatchment,
  0.01 as NImperv, -- default value, Manning's n for overland flow over the impervious portion of the subcatchment 
  0.1 as NPerv,-- default value, Manning's n for overland flow over the pervious portion of the subcatchment
  CASE
	WHEN surface_storage IS NOT NULL THEN surface_storage	
	ELSE 0.05 -- default value
  END as SImperv,-- Depth of depression storage on the impervious portion of the subcatchment (inches or millimeters)
    CASE
	WHEN surface_storage IS NOT NULL THEN surface_storage	
	ELSE 0.05 -- default value
  END as SPerv,-- Depth of depression storage on the pervious portion of the subcatchment (inches or millimeters)
  25 as PctZero,-- default value, Percent of the impervious area with no depression storage.
  'OUTLET'::varchar as RouteTo,
  NULL::float as PctRouted,
  ca.identifier || ', ' || ca.remark as description,
  ca.obj_id::varchar as tag,
  state as state,
  CASE 
		WHEN _function_hierarchic in (5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074) THEN 'primary'
		ELSE 'secondary'
	END as hierarchy,
  wn_obj_id as obj_id
FROM 
(
SELECT ca.*, sr.surface_storage, 'rw_current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.surface_runoff_parameters sr ON ca.obj_id = sr.fk_catchment_area
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*, sr.surface_storage, 'ww_current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.surface_runoff_parameters sr ON ca.obj_id = sr.fk_catchment_area
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_ww_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_ww_current IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*, sr.surface_storage, 'rw_planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.surface_runoff_parameters sr ON ca.obj_id = sr.fk_catchment_area
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_planned
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_planned IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*, sr.surface_storage, 'ww_planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.surface_runoff_parameters sr ON ca.obj_id = sr.fk_catchment_area
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_ww_planned
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_ww_planned IS NOT NULL -- to avoid unconnected catchments
) as ca;

-- Creates Dry Weather Flow related to the catchment area
CREATE OR REPLACE VIEW qgep_swmm.vw_dwf AS
SELECT
	CASE 
		WHEN type_ca = 'rw_current' THEN fk_wastewater_networkelement_rw_current
		WHEN type_ca = 'rw_planned' THEN fk_wastewater_networkelement_rw_planned
		WHEN type_ca = 'ww_current' THEN fk_wastewater_networkelement_ww_current
		WHEN type_ca = 'ww_planned' THEN fk_wastewater_networkelement_ww_planned
	END as Node, -- id of the junction
	'FLOW'::varchar as Constituent,
	CASE
		WHEN fk_wastewater_networkelement_ww_current is not null
		THEN 
			CASE 
				WHEN waste_water_production_current IS NOT NULL THEN waste_water_production_current 
				ELSE
					CASE 
						WHEN (surface_area IS NOT NULL AND surface_area != 0) THEN coalesce(population_density_current,0) * surface_area * 160 / (24 * 60 * 60)
						ELSE coalesce(population_density_current,0) * ST_Area(perimeter_geometry) * 160 / (24 * 60 * 60)
					END
			END
		WHEN fk_wastewater_networkelement_ww_planned is not null
		THEN 
			CASE 
				WHEN waste_water_production_planned IS NOT NULL THEN waste_water_production_planned
				ELSE
					CASE 
						WHEN (surface_area IS NOT NULL AND surface_area != 0) THEN coalesce(population_density_planned,0) * surface_area * 160 / (24 * 60 * 60)
						ELSE coalesce(population_density_planned,0) * ST_Area(perimeter_geometry) * 160 / (24 * 60 * 60)
					END
			END
		WHEN fk_wastewater_networkelement_rw_current is not null
		THEN 0
		WHEN fk_wastewater_networkelement_rw_planned is not null
		THEN 0
	END as Baseline, -- 160 Litre / inhabitant /day
	CASE
		WHEN fk_wastewater_networkelement_ww_current is not null
		THEN 
			CASE 
				WHEN waste_water_production_current IS NOT NULL THEN concat('catchment_area: ', ca.obj_id,': DWF baseline is computed from waste_water_production_current')
				ELSE
					CASE 
						WHEN (surface_area IS NOT NULL AND surface_area != 0) THEN concat('catchment_area: ', ca.obj_id,': DWF baseline is computed from surface_area, population_density_current and a default production of 160 Litre / inhabitant /day')
						ELSE concat('catchment_area: ', ca.obj_id,': DWF baseline is computed from the geometric area, population_density_current and a default production of 160 Litre / inhabitant /day')
					END
			END
		WHEN fk_wastewater_networkelement_ww_planned is not null
		THEN 
			CASE 
				WHEN waste_water_production_planned IS NOT NULL THEN concat('catchment_area: ', ca.obj_id,': DWF baseline is computed from waste_water_production_planned')
				ELSE
					CASE 
						WHEN (surface_area IS NOT NULL AND surface_area != 0) THEN concat('catchment_area: ', ca.obj_id,': DWF baseline is computed from surface_area, population_density_planned and a default production of 160 Litre / inhabitant /day')
						ELSE concat('catchment_area: ', ca.obj_id,': DWF baseline is computed from the geometric area, population_density_planned and a default production of 160 Litre / inhabitant /day')
					END
			END
		WHEN fk_wastewater_networkelement_rw_current is not null
		THEN ''
		WHEN fk_wastewater_networkelement_rw_planned is not null
		THEN ''
	END as message,
	'dailyPatternDWF'::varchar as Patterns,
	state as state,
  CASE 
		WHEN _function_hierarchic in (5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074) THEN 'primary'
		ELSE 'secondary'
	END as hierarchy,
  wn_obj_id as obj_id
FROM 
(
SELECT ca.*,'current' as state, 'rw_current' as type_ca
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*,'planned' as state, 'rw_planned' as type_ca wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_planned
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_planned IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*,'current' as state, 'ww_current' as type_ca
FROM qgep_od.catchment_area as ca
WHERE fk_wastewater_networkelement_ww_current IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*,'planned' as state, 'ww_planned' as type_ca
FROM qgep_od.catchment_area as ca
WHERE fk_wastewater_networkelement_ww_planned IS NOT NULL -- to avoid unconnected catchments
) as ca;

-- Creates a default raingage for each subcatchment
CREATE OR REPLACE VIEW qgep_swmm.vw_raingages AS
SELECT
  ('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as Name,
  'INTENSITY'::varchar as Format,
  '0:15'::varchar as Interval,
  '1.0'::varchar as SCF,
  'TIMESERIES default_qgep_raingage_timeserie'::varchar as Source,
  st_centroid(perimeter_geometry)::geometry(Point, %(SRID)s) as geom,
  state,
  CASE 
		WHEN _function_hierarchic in (5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074) THEN 'primary'
		ELSE 'secondary'
	END as hierarchy,
  wn_obj_id as obj_id
FROM 
(
SELECT ca.*,'current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL -- to avoid unconnected catchments
UNION
SELECT ca.*,'planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_planned
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_planned IS NOT NULL -- to avoid unconnected catchments
UNION
SELECT ca.*,'current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_ww_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_ww_current IS NOT NULL -- to avoid unconnected catchments
UNION
SELECT ca.*,'planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_ww_planned
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_ww_planned IS NOT NULL -- to avoid unconnected catchments
) as ca;

-- Creates default infiltration for each subcatchment
CREATE OR REPLACE VIEW qgep_swmm.vw_infiltration AS
SELECT
  CASE 
    WHEN state = 'current' THEN concat(replace(ca.obj_id, ' ', '_'), '_', 'rw_current')
    WHEN state = 'planned' THEN concat(replace(ca.obj_id, ' ', '_'), '_', 'rw_planned')
  END as Subcatchment,
  3 as MaxRate,
  0.5 as MinRate,
  4 as Decay,
  7 as DryTime,
  0 as MaxInfil,
  state,
  CASE 
		WHEN _function_hierarchic in (5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074) THEN 'primary'
		ELSE 'secondary'
	END as hierarchy,
  wn_obj_id as obj_id
FROM 
(
SELECT ca.*,'current' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_current IS NOT NULL -- to avoid unconnected catchments
UNION ALL
SELECT ca.*,'planned' as state, wn.obj_id as wn_obj_id, ws._function_hierarchic
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id = fk_wastewater_networkelement_rw_planned
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
WHERE fk_wastewater_networkelement_rw_planned IS NOT NULL -- to avoid unconnected catchments
) as ca;


-- creates coverages
CREATE OR REPLACE VIEW qgep_swmm.vw_coverages AS
SELECT
  sub.Name  as Subcatchment,
  pzk.value_en as landUse,
  round((st_area(st_intersection(sub.geom, pz.perimeter_geometry))/st_area(sub.geom))::numeric,2)*100 as percent
FROM qgep_swmm.vw_subcatchments sub, qgep_od.planning_zone pz
LEFT JOIN qgep_vl.planning_zone_kind pzk on pz.kind = pzk.code
WHERE st_intersects(sub.geom, pz.perimeter_geometry)
AND st_isvalid(sub.geom) AND st_isvalid(pz.perimeter_geometry)
ORDER BY sub.Name, percent DESC;
