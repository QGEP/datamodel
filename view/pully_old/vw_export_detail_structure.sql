CREATE OR REPLACE VIEW qgep_sigip.vw_export_detail_structure AS
 SELECT vw_qgep_wastewater_structure.obj_id,
    vw_qgep_wastewater_structure.identifier AS identification,
    vw_qgep_wastewater_structure.ws_type AS type,
    coalesce(manhole_function.value_fr, special_structure_function.value_fr) AS fonction,
    material.value_fr AS materiau,
    vw_qgep_wastewater_structure.ma_dimension1 AS longueur,
    vw_qgep_wastewater_structure.ma_dimension2 AS largeur,
    status.value_fr AS statut,
    positional_accuracy.value_fr AS precplan,
    vw_qgep_wastewater_structure.co_level AS altitude_couvercle,
    vw_qgep_wastewater_structure.wn_bottom_level AS altitude_radier,
    owner.identifier AS proprietaire,
    vw_qgep_wastewater_structure._depth AS profondeur,
    vw_qgep_wastewater_structure.year_of_construction AS annee_construction,
    usage.value_fr AS genre_utilisation,
    fonction_hierarchique.value_fr AS fonction_hierarchique,
    vw_qgep_wastewater_structure.pully_validation as validation,
    vw_qgep_wastewater_structure._label,
    wastewater_structure.detail_geometry_geometry
    --vw_qgep_wastewater_structure.situation_geometry

   FROM qgep_od.vw_qgep_wastewater_structure vw_qgep_wastewater_structure
     LEFT JOIN qgep_vl.cover_cover_shape cover_shape ON cover_shape.code = vw_qgep_wastewater_structure.co_shape
     LEFT JOIN qgep_vl.cover_fastening cover_fastening ON cover_fastening.code = vw_qgep_wastewater_structure.co_fastening
     LEFT JOIN qgep_vl.cover_material cover_material ON cover_material.code = vw_qgep_wastewater_structure.co_material
     LEFT JOIN qgep_vl.cover_positional_accuracy positional_accuracy ON positional_accuracy.code = vw_qgep_wastewater_structure.co_positional_accuracy
     LEFT JOIN qgep_vl.cover_sludge_bucket sludge_bucket ON sludge_bucket.code = vw_qgep_wastewater_structure.co_sludge_bucket
     LEFT JOIN qgep_vl.cover_venting venting ON venting.code = vw_qgep_wastewater_structure.co_venting
     LEFT JOIN qgep_vl.structure_part_renovation_demand renovation_demand ON renovation_demand.code = vw_qgep_wastewater_structure.co_renovation_demand
     LEFT JOIN qgep_vl.wastewater_structure_financing financing ON financing.code = vw_qgep_wastewater_structure.financing
     LEFT JOIN qgep_vl.wastewater_structure_renovation_necessity renovation_necessity ON renovation_necessity.code = vw_qgep_wastewater_structure.renovation_necessity
     LEFT JOIN qgep_vl.wastewater_structure_rv_construction_type rv_construction_type ON rv_construction_type.code = vw_qgep_wastewater_structure.rv_construction_type
     LEFT JOIN qgep_vl.wastewater_structure_status status ON status.code = vw_qgep_wastewater_structure.status
     LEFT JOIN qgep_vl.wastewater_structure_structure_condition structure_condition ON structure_condition.code = vw_qgep_wastewater_structure.structure_condition
     LEFT JOIN qgep_od.organisation owner ON owner.obj_id::text = vw_qgep_wastewater_structure.fk_owner::text
     LEFT JOIN qgep_od.organisation operator ON operator.obj_id::text = vw_qgep_wastewater_structure.fk_operator::text
     LEFT JOIN qgep_vl.manhole_function manhole_function ON manhole_function.code = vw_qgep_wastewater_structure.ma_function
     LEFT JOIN qgep_vl.manhole_material material ON material.code = vw_qgep_wastewater_structure.ma_material
     LEFT JOIN qgep_vl.manhole_surface_inflow surface_inflow ON surface_inflow.code = vw_qgep_wastewater_structure.ma_surface_inflow
     LEFT JOIN qgep_vl.special_structure_bypass bypass ON bypass.code = vw_qgep_wastewater_structure.ss_bypass
     LEFT JOIN qgep_vl.special_structure_function special_structure_function ON special_structure_function.code = vw_qgep_wastewater_structure.ss_function
     LEFT JOIN qgep_vl.special_structure_stormwater_tank_arrangement stormwater_tank_arrangement ON stormwater_tank_arrangement.code = vw_qgep_wastewater_structure.ss_stormwater_tank_arrangement
     LEFT JOIN qgep_vl.discharge_point_relevance relevance ON relevance.code = vw_qgep_wastewater_structure.dp_relevance
     LEFT JOIN qgep_od.wastewater_structure ON vw_qgep_wastewater_structure.obj_id = wastewater_structure.obj_id
     LEFT JOIN qgep_vl.channel_usage_current usage ON usage.code = vw_qgep_wastewater_structure._channel_usage_current
     LEFT JOIN qgep_vl.channel_function_hierarchic fonction_hierarchique ON fonction_hierarchique.code = vw_qgep_wastewater_structure._channel_function_hierarchic
WHERE wastewater_structure.detail_geometry_geometry is NOT NULL
;
