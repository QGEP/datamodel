
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
            WHEN ca.surface_area IS NULL THEN st_area(ca.perimeter_geometry)/10000
            WHEN ca.surface_area < 0.01 THEN st_area(ca.perimeter_geometry)/10000
            ELSE (ca.surface_area::numeric)::double precision
  END AS Area,
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
		THEN NULL
		WHEN fk_wastewater_networkelement_rw_planned is not null
		THEN NULL
	END as description,
  ca.obj_id as tag,
  ST_CurveToLine(perimeter_geometry)::geometry(Polygon, %(SRID)s) as geom,
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
  SELECT ca_1.obj_id,
            ddc.vsacode as direct_discharge_current,
            ddp.vsacode as direct_discharge_planned,
            ca_1.discharge_coefficient_rw_current,
            ca_1.discharge_coefficient_rw_planned,
            ca_1.discharge_coefficient_ww_current,
            ca_1.discharge_coefficient_ww_planned,
            dsc.vsacode as drainage_system_current,
            dsp.vsacode as drainage_system_planned,
            ca_1.identifier,
            ic.vsacode as infiltration_current,
            ip.vsacode as infiltration_planned,
            ca_1.perimeter_geometry,
            ca_1.population_density_current,
            ca_1.population_density_planned,
            ca_1.remark,
            rc.vsacode as retention_current,
            rp.vsacode as retention_planned,
            ca_1.runoff_limit_current,
            ca_1.runoff_limit_planned,
            ca_1.seal_factor_rw_current,
            ca_1.seal_factor_rw_planned,
            ca_1.seal_factor_ww_current,
            ca_1.seal_factor_ww_planned,
            ca_1.sewer_infiltration_water_production_current,
            ca_1.sewer_infiltration_water_production_planned,
            ca_1.surface_area,
            ca_1.waste_water_production_current,
            ca_1.waste_water_production_planned,
            ca_1.last_modification,
            ca_1.fk_dataowner,
            ca_1.fk_provider,
            ca_1.fk_wastewater_networkelement_rw_current,
            ca_1.fk_wastewater_networkelement_rw_planned,
            ca_1.fk_wastewater_networkelement_ww_planned,
            ca_1.fk_wastewater_networkelement_ww_current,
            wn.situation_geometry AS wn_geom,
            CASE WHEN ca_1.fk_wastewater_networkelement_rw_current =wn.obj_id
			THEN 'rw_current'::text
			WHEN ca_1.fk_wastewater_networkelement_ww_current =wn.obj_id
			THEN 'ww_current'::text
			WHEN ca_1.fk_wastewater_networkelement_rw_planned =wn.obj_id
			THEN 'rw_planned'::text
			WHEN ca_1.fk_wastewater_networkelement_ww_planned =wn.obj_id
			THEN 'ww_planned'::text
			ELSE 'ERROR'
			END AS state,
            wn.obj_id AS wn_obj_id,
            fhy.vsacode as _function_hierarchic
           FROM qgep_od.catchment_area ca_1
             JOIN qgep_od.wastewater_networkelement ne 
			 	ON ne.obj_id::text IN (ca_1.fk_wastewater_networkelement_rw_current::text,
						       ca_1.fk_wastewater_networkelement_ww_current::text,
						       ca_1.fk_wastewater_networkelement_rw_planned::text,
						       ca_1.fk_wastewater_networkelement_ww_planned::text)
             LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id::text = ne.obj_id::text
	     LEFT JOIN qgep_vl.catchment_area_direct_discharge_current ddc ON ddc.code=ca_1.direct_discharge_current
	     LEFT JOIN qgep_vl.catchment_area_direct_discharge_planned ddp ON ddp.code=ca_1.direct_discharge_planned
	     LEFT JOIN qgep_vl.catchment_area_drainage_system_current dsc ON dsc.code=ca_1.drainage_system_current
	     LEFT JOIN qgep_vl.catchment_area_drainage_system_planned dsp ON dsp.code=ca_1.drainage_system_planned
	     LEFT JOIN qgep_vl.catchment_area_infiltration_current ic ON ic.code=ca_1.infiltration_current
	     LEFT JOIN qgep_vl.catchment_area_infiltration_planned ip ON ip.code=ca_1.infiltration_planned
	     LEFT JOIN qgep_vl.catchment_area_retention_current rc ON rc.code=ca_1.retention_current
	     LEFT JOIN qgep_vl.catchment_area_retention_planned rp ON rp.code=ca_1.retention_planned	
	     LEFT JOIN qgep_vl.channel_function_hierarchic fhy ON fhy.code=wn._function_hierarchic
) as ca;
