CREATE OR REPLACE VIEW qgep_sigip.vw_export_reach_from AS
  SELECT
    re.obj_id AS re_obj_id,
    ws.obj_id AS fk_ws_obj_id,
    ws.wn_obj_id AS fk_wn_obj_id,
    re.identifier AS identification,
    function_hierarchic.value_fr AS fonction_hierarchique,
    usage_current.value_fr AS genre_utilisation,
    re.clear_height AS diametre_hauteur,
    re.width AS largeur,
    fk_pipe_profile.identifier AS genre_profil,
    material.value_fr AS materiau,
    material.abbr_fr AS material_abbr,
    re.ch_pipe_length AS longueur_mesuree,
    status.value_fr AS statut,
    structure_condition.value_fr AS etat,
    horizontal_positioning.value_fr AS precplan,
    owner.identifier AS proprietaire,
    re.ws_year_of_construction AS annee_construction,
    re.rp_from_level AS altitude_depart,
    re.rp_to_level AS altitude_arrivee,
    re.ws_remark AS remarque,
    re.ws_pully_validation AS validation,
    re.progression_geometry AS the_geom

  FROM qgep_od.vw_qgep_wastewater_structure ws
  FULL JOIN qgep_od.vw_qgep_reach re on re.rp_from_fk_wastewater_networkelement = ws.wn_obj_id
  LEFT JOIN qgep_vl.reach_elevation_determination elevation_determination ON elevation_determination.code = re.elevation_determination
  LEFT JOIN qgep_vl.reach_horizontal_positioning horizontal_positioning ON horizontal_positioning.code = re.horizontal_positioning
  LEFT JOIN qgep_vl.reach_inside_coating inside_coating ON inside_coating.code = re.inside_coating
  LEFT JOIN qgep_vl.reach_material material ON material.code = re.material
  LEFT JOIN qgep_vl.reach_reliner_material reliner_material ON reliner_material.code = re.reliner_material
  LEFT JOIN qgep_vl.reach_relining_construction relining_construction ON relining_construction.code = re.relining_construction
  LEFT JOIN qgep_vl.reach_relining_kind relining_kind ON relining_kind.code = re.relining_kind
  LEFT JOIN qgep_od.pipe_profile fk_pipe_profile ON fk_pipe_profile.obj_id::text = re.fk_pipe_profile::text
  LEFT JOIN qgep_vl.channel_function_hierarchic function_hierarchic ON function_hierarchic.code = re.ch_function_hierarchic
  LEFT JOIN qgep_vl.channel_connection_type connection_type ON connection_type.code = re.ch_connection_type
  LEFT JOIN qgep_vl.channel_function_hydraulic function_hydraulic ON function_hydraulic.code = re.ch_function_hydraulic
  LEFT JOIN qgep_vl.channel_usage_current usage_current ON usage_current.code = re.ch_usage_current
  LEFT JOIN qgep_vl.channel_usage_planned usage_planned ON usage_planned.code = re.ch_usage_planned
  LEFT JOIN qgep_vl.wastewater_structure_accessibility accessibility ON accessibility.code = re.ws_accessibility
  LEFT JOIN qgep_vl.wastewater_structure_financing financing ON financing.code = re.ws_financing
  LEFT JOIN qgep_vl.wastewater_structure_renovation_necessity renovation_necessity ON renovation_necessity.code = re.ws_renovation_necessity
  LEFT JOIN qgep_vl.wastewater_structure_rv_construction_type rv_construction_type ON rv_construction_type.code = re.ws_rv_construction_type
  LEFT JOIN qgep_vl.wastewater_structure_status status ON status.code = re.ws_status
  LEFT JOIN qgep_vl.wastewater_structure_structure_condition structure_condition ON structure_condition.code = re.ws_structure_condition
  LEFT JOIN qgep_od.organisation owner ON owner.obj_id::text = re.ws_fk_owner::text
  LEFT JOIN qgep_od.organisation operator ON operator.obj_id::text = re.ws_fk_operator::text

  WHERE re.rp_from_fk_wastewater_networkelement is not null
  AND ws.obj_id is not NULL;
