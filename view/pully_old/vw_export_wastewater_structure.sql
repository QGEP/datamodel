CREATE OR REPLACE VIEW qgep_sigip.vw_export_wastewater_structure AS
SELECT ws.obj_id,
    ws.identifier AS identification,
    ws.ws_type AS type,
    coalesce(manhole_function.value_fr, special_structure_function.value_fr) AS fonction,
    material.value_fr AS materiau,
    ws.ma_dimension1 AS longueur,
    ws.ma_dimension2 AS largeur,
    status.value_fr AS statut,
    positional_accuracy.value_fr AS precplan,
    ws.co_level AS altitude_couvercle,
    ws.wn_bottom_level AS altitude_radier,
    owner.identifier AS proprietaire,
    ws._depth AS profondeur,
    ws.year_of_construction AS annee_construction,
    usage.value_fr AS genre_utilisation,
    fonction_hierarchique.value_fr AS fonction_hierarchique,
    ws.pully_validation as validation,
    ws.remark as remarque,
    concat(ws._label, ws._cover_label, ws._bottom_label, ws._input_label, ws._output_label) as label,
    ws.wn_pully_orientation AS orientation,
    --wastewater_structure.detail_geometry_geometry,
    ws.situation_geometry

   FROM qgep_od.vw_qgep_wastewater_structure ws
     LEFT JOIN qgep_vl.cover_cover_shape cover_shape ON cover_shape.code = ws.co_shape
     LEFT JOIN qgep_vl.cover_fastening cover_fastening ON cover_fastening.code = ws.co_fastening
     LEFT JOIN qgep_vl.cover_material cover_material ON cover_material.code = ws.co_material
     LEFT JOIN qgep_vl.cover_positional_accuracy positional_accuracy ON positional_accuracy.code = ws.co_positional_accuracy
     LEFT JOIN qgep_vl.cover_sludge_bucket sludge_bucket ON sludge_bucket.code = ws.co_sludge_bucket
     LEFT JOIN qgep_vl.cover_venting venting ON venting.code = ws.co_venting
     LEFT JOIN qgep_vl.structure_part_renovation_demand renovation_demand ON renovation_demand.code = ws.co_renovation_demand
     LEFT JOIN qgep_vl.wastewater_structure_financing financing ON financing.code = ws.financing
     LEFT JOIN qgep_vl.wastewater_structure_renovation_necessity renovation_necessity ON renovation_necessity.code = ws.renovation_necessity
     LEFT JOIN qgep_vl.wastewater_structure_rv_construction_type rv_construction_type ON rv_construction_type.code = ws.rv_construction_type
     LEFT JOIN qgep_vl.wastewater_structure_status status ON status.code = ws.status
     LEFT JOIN qgep_vl.wastewater_structure_structure_condition structure_condition ON structure_condition.code = ws.structure_condition
     LEFT JOIN qgep_od.organisation owner ON owner.obj_id::text = ws.fk_owner::text
     LEFT JOIN qgep_od.organisation operator ON operator.obj_id::text = ws.fk_operator::text
     LEFT JOIN qgep_vl.manhole_function manhole_function ON manhole_function.code = ws.ma_function
     LEFT JOIN qgep_vl.manhole_material material ON material.code = ws.ma_material
     LEFT JOIN qgep_vl.manhole_surface_inflow surface_inflow ON surface_inflow.code = ws.ma_surface_inflow
     LEFT JOIN qgep_vl.special_structure_bypass bypass ON bypass.code = ws.ss_bypass
     LEFT JOIN qgep_vl.special_structure_function special_structure_function ON special_structure_function.code = ws.ss_function
     LEFT JOIN qgep_vl.special_structure_stormwater_tank_arrangement stormwater_tank_arrangement ON stormwater_tank_arrangement.code = ws.ss_stormwater_tank_arrangement
     LEFT JOIN qgep_vl.discharge_point_relevance relevance ON relevance.code = ws.dp_relevance
     LEFT JOIN qgep_od.wastewater_structure ON ws.obj_id = wastewater_structure.obj_id
     LEFT JOIN qgep_vl.channel_usage_current usage ON usage.code = ws._channel_usage_current
     LEFT JOIN qgep_vl.channel_function_hierarchic fonction_hierarchique ON fonction_hierarchique.code = ws._channel_function_hierarchic
WHERE ws.situation_geometry is NOT NULL;
