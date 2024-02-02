--DROP VIEW IF EXISTS qgep_sigip.vw_details_ouvrages;

CREATE OR REPLACE VIEW qgep_sigip.vw_details_ouvrages AS

  SELECT ws.obj_id,
    ws.identifier AS identification,
    CASE
      WHEN ma.obj_id IS NOT NULL THEN 'manhole'::text
      WHEN ss.obj_id IS NOT NULL THEN 'special_structure'::text
      WHEN dp.obj_id IS NOT NULL THEN 'discharge_point'::text
      WHEN ii.obj_id IS NOT NULL THEN 'infiltration_installation'::text
      ELSE 'unknown'::text
    END AS type,
    COALESCE(manhole_function.value_fr, special_structure_function.value_fr) AS fonction,
    material.value_fr AS materiau,
    COALESCE(ma.dimension1, ii.dimension1) AS longueur,
    COALESCE(ma.dimension2, ii.dimension2) AS largeur,
    status.value_fr AS statut,
    positional_accuracy.value_fr AS precplan,
	  main_co.level AS altitude_couvercle,
    cover_fastening.value_fr AS fixation_couvercle,
    wn.bottom_level AS altitude_radier,
	  owner.identifier AS proprietaire,
    ws._depth AS profondeur,
    accessibility.value_fr AS accessibilite,
    ws.year_of_construction AS annee_construction,
    usage_current.value_fr AS genre_utilisation,
    usage_expected.value_fr as usage_attendu,
    function_hierarchic.value_fr AS fonction_hierarchique,
    ws.pully_validation AS validation,
    ws.remark AS remarque,
    concat(ws._label, ws._cover_label, ws._bottom_label, ws._input_label, ws._output_label) AS label,
    wn.pully_orientation AS orientation,
    ws.detail_geometry_geometry

  FROM qgep_od.wastewater_structure ws 
    LEFT JOIN qgep_od.cover main_co ON main_co.obj_id::text = ws.fk_main_cover::text
    LEFT JOIN qgep_od.structure_part main_co_sp ON main_co_sp.obj_id::text = ws.fk_main_cover::text
    LEFT JOIN qgep_od.manhole ma ON ma.obj_id::text = ws.obj_id::text
    LEFT JOIN qgep_od.special_structure ss ON ss.obj_id::text = ws.obj_id::text
    LEFT JOIN qgep_od.discharge_point dp ON dp.obj_id::text = ws.obj_id::text
    LEFT JOIN qgep_od.infiltration_installation ii ON ii.obj_id::text = ws.obj_id::text
    LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = ws.fk_main_wastewater_node::text
    LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id::text = ws.fk_main_wastewater_node::text
    LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ws.obj_id::text

    LEFT JOIN qgep_vl.manhole_function manhole_function ON manhole_function.code = ma.function
    LEFT JOIN qgep_vl.special_structure_function special_structure_function ON special_structure_function.code = ss.function
    LEFT JOIN qgep_vl.manhole_material material ON material.code = ma.material
    LEFT JOIN qgep_vl.wastewater_structure_status status ON status.code = ws.status
    LEFT JOIN qgep_vl.wastewater_structure_accessibility accessibility ON accessibility.code = ws.accessibility
    LEFT JOIN qgep_vl.cover_positional_accuracy positional_accuracy ON positional_accuracy.code = main_co.positional_accuracy
    LEFT JOIN qgep_vl.cover_fastening cover_fastening ON cover_fastening.code = main_co.fastening
    LEFT JOIN qgep_od.organisation owner ON owner.obj_id::text = ws.fk_owner::text
    LEFT JOIN qgep_vl.channel_usage_current usage_current ON usage_current.code = ws._usage_current
    LEFT JOIN qgep_vl.pully_node_usage_expected usage_expected ON usage_expected.code = wn.pully_fk_usage_expected
    LEFT JOIN qgep_vl.channel_function_hierarchic function_hierarchic ON function_hierarchic.code = ws._function_hierarchic

    /*
    LEFT JOIN qgep_vl.cover_cover_shape cover_shape ON cover_shape.code = ws.co_shape
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
    LEFT JOIN qgep_od.organisation operator ON operator.obj_id::text = vw_qgep_wastewater_structure.fk_operator::text
    
    LEFT JOIN qgep_vl.manhole_surface_inflow surface_inflow ON surface_inflow.code = vw_qgep_wastewater_structure.ma_surface_inflow
    LEFT JOIN qgep_vl.special_structure_bypass bypass ON bypass.code = vw_qgep_wastewater_structure.ss_bypass
    LEFT JOIN qgep_vl.special_structure_stormwater_tank_arrangement stormwater_tank_arrangement ON stormwater_tank_arrangement.code = vw_qgep_wastewater_structure.ss_stormwater_tank_arrangement
    LEFT JOIN qgep_vl.discharge_point_relevance relevance ON relevance.code = vw_qgep_wastewater_structure.dp_relevance
     */
   WHERE ws.detail_geometry_geometry IS NOT NULL;
