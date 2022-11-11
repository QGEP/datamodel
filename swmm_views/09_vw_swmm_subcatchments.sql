
--------
-- View for the swmm module class subcatchments
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