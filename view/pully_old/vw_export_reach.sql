CREATE OR REPLACE VIEW qgep_sigip.vw_export_reach AS
 SELECT vw_qgep_reach.obj_id,
    vw_qgep_reach.identifier AS identification,
    function_hierarchic.value_fr AS fonction_hierarchique,
    usage_current.value_fr AS genre_utilisation,
    vw_qgep_reach.clear_height AS diametre_hauteur,
    vw_qgep_reach.width AS largeur,
    fk_pipe_profile.identifier AS genre_profil,
    material.value_fr AS materiau,
    material.abbr_fr AS material_abbr,
    vw_qgep_reach.ch_pipe_length AS longueur_mesuree,
    status.value_fr AS statut,
    structure_condition.value_fr AS etat,
    horizontal_positioning.value_fr AS precplan,
    owner.identifier AS proprietaire,
    vw_qgep_reach.ws_year_of_construction AS annee_construction,
    vw_qgep_reach.rp_from_level AS altitude_depart,
    vw_qgep_reach.rp_to_level AS altitude_arrivee,
    vw_qgep_reach.ws_remark AS remarque,
    vw_qgep_reach.ws_pully_validation AS validation,
    vw_qgep_reach.progression_geometry AS the_geom

   FROM qgep_od.vw_qgep_reach
     LEFT JOIN qgep_vl.reach_elevation_determination elevation_determination ON elevation_determination.code = vw_qgep_reach.elevation_determination
     LEFT JOIN qgep_vl.reach_horizontal_positioning horizontal_positioning ON horizontal_positioning.code = vw_qgep_reach.horizontal_positioning
     LEFT JOIN qgep_vl.reach_inside_coating inside_coating ON inside_coating.code = vw_qgep_reach.inside_coating
     LEFT JOIN qgep_vl.reach_material material ON material.code = vw_qgep_reach.material
     LEFT JOIN qgep_vl.reach_reliner_material reliner_material ON reliner_material.code = vw_qgep_reach.reliner_material
     LEFT JOIN qgep_vl.reach_relining_construction relining_construction ON relining_construction.code = vw_qgep_reach.relining_construction
     LEFT JOIN qgep_vl.reach_relining_kind relining_kind ON relining_kind.code = vw_qgep_reach.relining_kind
     LEFT JOIN qgep_od.pipe_profile fk_pipe_profile ON fk_pipe_profile.obj_id::text = vw_qgep_reach.fk_pipe_profile::text
     LEFT JOIN qgep_vl.channel_function_hierarchic function_hierarchic ON function_hierarchic.code = vw_qgep_reach.ch_function_hierarchic
     LEFT JOIN qgep_vl.channel_connection_type connection_type ON connection_type.code = vw_qgep_reach.ch_connection_type
     LEFT JOIN qgep_vl.channel_function_hydraulic function_hydraulic ON function_hydraulic.code = vw_qgep_reach.ch_function_hydraulic
     LEFT JOIN qgep_vl.channel_usage_current usage_current ON usage_current.code = vw_qgep_reach.ch_usage_current
     LEFT JOIN qgep_vl.channel_usage_planned usage_planned ON usage_planned.code = vw_qgep_reach.ch_usage_planned
     LEFT JOIN qgep_vl.wastewater_structure_accessibility accessibility ON accessibility.code = vw_qgep_reach.ws_accessibility
     LEFT JOIN qgep_vl.wastewater_structure_financing financing ON financing.code = vw_qgep_reach.ws_financing
     LEFT JOIN qgep_vl.wastewater_structure_renovation_necessity renovation_necessity ON renovation_necessity.code = vw_qgep_reach.ws_renovation_necessity
     LEFT JOIN qgep_vl.wastewater_structure_rv_construction_type rv_construction_type ON rv_construction_type.code = vw_qgep_reach.ws_rv_construction_type
     LEFT JOIN qgep_vl.wastewater_structure_status status ON status.code = vw_qgep_reach.ws_status
     LEFT JOIN qgep_vl.wastewater_structure_structure_condition structure_condition ON structure_condition.code = vw_qgep_reach.ws_structure_condition
     LEFT JOIN qgep_od.organisation owner ON owner.obj_id::text = vw_qgep_reach.ws_fk_owner::text
     LEFT JOIN qgep_od.organisation operator ON operator.obj_id::text = vw_qgep_reach.ws_fk_operator::text;

