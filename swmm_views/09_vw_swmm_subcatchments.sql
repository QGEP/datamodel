
--------
-- View for the swmm module class subcatchments
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_subcatchments
 AS
 SELECT concat(replace(ca.obj_id::text, ' '::text, '_'::text), '_', ca.state) AS name,
    concat('raingage_'::text || substr(ca.state,4))::character varying AS raingage,
        CASE
            WHEN ca.state = 'rw_current'::text THEN ca.fk_wastewater_networkelement_rw_current::text
            WHEN ca.state = 'rw_planned'::text THEN ca.fk_wastewater_networkelement_rw_planned::text
            WHEN ca.state = 'ww_current'::text THEN ca.fk_wastewater_networkelement_ww_current::text
            WHEN ca.state = 'ww_planned'::text THEN ca.fk_wastewater_networkelement_ww_planned::text
            ELSE replace(ca.obj_id::text, ' '::text, '_'::text)
        END AS outlet,
        CASE
            WHEN ca.surface_area IS NULL THEN st_area(ca.perimeter_geometry) / 10000::double precision
            WHEN ca.surface_area < 0.01 THEN st_area(ca.perimeter_geometry) / 10000::double precision
            ELSE ca.surface_area::numeric::double precision
        END AS area,
        CASE
            WHEN ca.state = 'rw_current'::text THEN ca.discharge_coefficient_rw_current
            WHEN ca.state = 'rw_planned'::text THEN ca.discharge_coefficient_rw_planned
            WHEN ca.state = 'ww_current'::text THEN ca.discharge_coefficient_ww_current
            WHEN ca.state = 'ww_planned'::text THEN ca.discharge_coefficient_ww_planned
            ELSE 0::numeric
        END AS percimperv, -- take from catchment_area instead of default value
        CASE
            WHEN ca.wn_geom IS NOT NULL THEN (st_maxdistance(ca.wn_geom, st_exteriorring(ca.perimeter_geometry)) + st_distance(ca.wn_geom, st_exteriorring(ca.perimeter_geometry))) / 2::double precision
            ELSE (st_maxdistance(st_centroid(ca.perimeter_geometry), st_exteriorring(ca.perimeter_geometry)) + st_distance(st_centroid(ca.perimeter_geometry), st_exteriorring(ca.perimeter_geometry))) / 2::double precision
        END AS width, -- Width of overland flow path estimation
    0.5 AS percslope, -- default value
    0 AS curblen, -- default value
    NULL::character varying AS snowpack, -- default value
        CASE
            WHEN ca.fk_wastewater_networkelement_ww_current IS NOT NULL THEN
            CASE
                WHEN ca.waste_water_production_current IS NOT NULL THEN concat('catchment_area: ', ca.obj_id, ': DWF baseline is computed from waste_water_production_current')
                ELSE
                CASE
                    WHEN ca.surface_area IS NOT NULL AND ca.surface_area <> 0::numeric THEN concat('catchment_area: ', ca.obj_id, ': DWF baseline is computed from surface_area, population_density_current and a default production of 160 Litre / inhabitant /day')
                    ELSE concat('catchment_area: ', ca.obj_id, ': DWF baseline is computed from the geometric area, population_density_current and a default production of 160 Litre / inhabitant /day')
                END
            END
            WHEN ca.fk_wastewater_networkelement_ww_planned IS NOT NULL THEN
            CASE
                WHEN ca.waste_water_production_planned IS NOT NULL THEN concat('catchment_area: ', ca.obj_id, ': DWF baseline is computed from waste_water_production_planned')
                ELSE
                CASE
                    WHEN ca.surface_area IS NOT NULL AND ca.surface_area <> 0::numeric THEN concat('catchment_area: ', ca.obj_id, ': DWF baseline is computed from surface_area, population_density_planned and a default production of 160 Litre / inhabitant /day')
                    ELSE concat('catchment_area: ', ca.obj_id, ': DWF baseline is computed from the geometric area, population_density_planned and a default production of 160 Litre / inhabitant /day')
                END
            END
            WHEN ca.fk_wastewater_networkelement_rw_current IS NOT NULL THEN NULL::text
            WHEN ca.fk_wastewater_networkelement_rw_planned IS NOT NULL THEN NULL::text
            ELSE NULL::text
        END AS description,
    ca.obj_id AS tag,
    st_curvetoline(ca.perimeter_geometry)::geometry(Polygon,2056) AS geom,
        CASE
            WHEN ca.state = 'rw_current'::text OR ca.state = 'ww_current'::text THEN 'current'::text
            WHEN ca.state = 'rw_planned'::text OR ca.state = 'ww_planned'::text THEN 'planned'::text
            ELSE 'planned'::text
        END AS state,
        CASE
            WHEN ca._function_hierarchic = ANY (ARRAY[5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074]) THEN 'primary'::text
            ELSE 'secondary'::text
        END AS hierarchy,
    ca.wn_obj_id AS obj_id
   FROM ( SELECT ca_1.obj_id,
            ddc.vsacode AS direct_discharge_current,
            ddp.vsacode AS direct_discharge_planned,
            ca_1.discharge_coefficient_rw_current,
            ca_1.discharge_coefficient_rw_planned,
            ca_1.discharge_coefficient_ww_current,
            ca_1.discharge_coefficient_ww_planned,
            dsc.vsacode AS drainage_system_current,
            dsp.vsacode AS drainage_system_planned,
            ca_1.identifier,
            ic.vsacode AS infiltration_current,
            ip.vsacode AS infiltration_planned,
            ca_1.perimeter_geometry,
            ca_1.population_density_current,
            ca_1.population_density_planned,
            ca_1.remark,
            rc.vsacode AS retention_current,
            rp.vsacode AS retention_planned,
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
                CASE
                    WHEN ca_1.fk_wastewater_networkelement_rw_current::text = wn.obj_id::text THEN 'rw_current'::text
                    WHEN ca_1.fk_wastewater_networkelement_ww_current::text = wn.obj_id::text THEN 'ww_current'::text
                    WHEN ca_1.fk_wastewater_networkelement_rw_planned::text = wn.obj_id::text THEN 'rw_planned'::text
                    WHEN ca_1.fk_wastewater_networkelement_ww_planned::text = wn.obj_id::text THEN 'ww_planned'::text
                    ELSE 'ERROR'::text
                END AS state,
            wn.obj_id AS wn_obj_id,
            fhy.vsacode AS _function_hierarchic
           FROM qgep_od.catchment_area ca_1
             JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = ca_1.fk_wastewater_networkelement_rw_current::text OR ne.obj_id::text = ca_1.fk_wastewater_networkelement_ww_current::text OR ne.obj_id::text = ca_1.fk_wastewater_networkelement_rw_planned::text OR ne.obj_id::text = ca_1.fk_wastewater_networkelement_ww_planned::text
             LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id::text = ne.obj_id::text
             LEFT JOIN qgep_vl.catchment_area_direct_discharge_current ddc ON ddc.code = ca_1.direct_discharge_current
             LEFT JOIN qgep_vl.catchment_area_direct_discharge_planned ddp ON ddp.code = ca_1.direct_discharge_planned
             LEFT JOIN qgep_vl.catchment_area_drainage_system_current dsc ON dsc.code = ca_1.drainage_system_current
             LEFT JOIN qgep_vl.catchment_area_drainage_system_planned dsp ON dsp.code = ca_1.drainage_system_planned
             LEFT JOIN qgep_vl.catchment_area_infiltration_current ic ON ic.code = ca_1.infiltration_current
             LEFT JOIN qgep_vl.catchment_area_infiltration_planned ip ON ip.code = ca_1.infiltration_planned
             LEFT JOIN qgep_vl.catchment_area_retention_current rc ON rc.code = ca_1.retention_current
             LEFT JOIN qgep_vl.catchment_area_retention_planned rp ON rp.code = ca_1.retention_planned
             LEFT JOIN qgep_vl.channel_function_hierarchic fhy ON fhy.code = wn._function_hierarchic) ca;
