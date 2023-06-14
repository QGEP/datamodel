CREATE OR REPLACE VIEW qgep_sigip.vw_troncons AS

  SELECT re.obj_id,
    ne.identifier AS identification,
    function_hierarchic.value_fr AS fonction_hierarchique,
    usage_current.value_fr AS genre_utilisation,
    re.clear_height AS diametre_hauteur,
    CASE
      WHEN pp.height_width_ratio IS NOT NULL THEN round(re.clear_height::numeric * pp.height_width_ratio)::smallint::integer
      ELSE re.clear_height
    END AS largeur,
    pp.identifier AS genre_profil,
    material.value_fr AS materiau,
    material.abbr_fr AS material_abbr,
    ch.pipe_length AS longueur_mesuree,
    ROUND(ST_Length(re.progression_geometry)::numeric,2) AS longueur_calculee,
    status.value_fr AS statut,
    horizontal_positioning.value_fr AS precplan,
    owner.identifier AS proprietaire,
    ws.year_of_construction AS annee_construction,
    rp_from.level AS altitude_depart,
    rp_to.level AS altitude_arrivee,
    ws.remark AS remarque,
    ws.pully_validation AS validation,
    re.progression_geometry AS the_geom

  FROM qgep_od.reach re
    LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
    LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id::text = re.fk_reach_point_from::text
    LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id::text = re.fk_reach_point_to::text
    LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure::text = ws.obj_id::text
    LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ws.obj_id::text
    LEFT JOIN qgep_od.pipe_profile pp ON re.fk_pipe_profile::text = pp.obj_id::text

    LEFT JOIN qgep_vl.reach_elevation_determination elevation_determination ON elevation_determination.code = re.elevation_determination
    LEFT JOIN qgep_vl.reach_horizontal_positioning horizontal_positioning ON horizontal_positioning.code = re.horizontal_positioning
    LEFT JOIN qgep_vl.reach_inside_coating inside_coating ON inside_coating.code = re.inside_coating
    LEFT JOIN qgep_vl.reach_material material ON material.code = re.material
    LEFT JOIN qgep_vl.reach_reliner_material reliner_material ON reliner_material.code = re.reliner_material
    LEFT JOIN qgep_vl.reach_relining_construction relining_construction ON relining_construction.code = re.relining_construction
    LEFT JOIN qgep_vl.reach_relining_kind relining_kind ON relining_kind.code = re.relining_kind
    LEFT JOIN qgep_vl.channel_function_hierarchic function_hierarchic ON function_hierarchic.code = ch.function_hierarchic
    LEFT JOIN qgep_vl.channel_connection_type connection_type ON connection_type.code = ch.connection_type
    LEFT JOIN qgep_vl.channel_function_hydraulic function_hydraulic ON function_hydraulic.code = ch.function_hydraulic
    LEFT JOIN qgep_vl.channel_usage_current usage_current ON usage_current.code = ch.usage_current
    LEFT JOIN qgep_vl.channel_usage_planned usage_planned ON usage_planned.code = ch.usage_planned
    LEFT JOIN qgep_vl.wastewater_structure_accessibility accessibility ON accessibility.code = ws.accessibility
    LEFT JOIN qgep_vl.wastewater_structure_financing financing ON financing.code = ws.financing
    LEFT JOIN qgep_vl.wastewater_structure_renovation_necessity renovation_necessity ON renovation_necessity.code = ws.renovation_necessity
    LEFT JOIN qgep_vl.wastewater_structure_rv_construction_type rv_construction_type ON rv_construction_type.code = ws.rv_construction_type
    LEFT JOIN qgep_vl.wastewater_structure_status status ON status.code = ws.status
    LEFT JOIN qgep_vl.wastewater_structure_structure_condition structure_condition ON structure_condition.code = ws.structure_condition
    LEFT JOIN qgep_od.organisation owner ON owner.obj_id::text = ws.fk_owner::text
    LEFT JOIN qgep_od.organisation operator ON operator.obj_id::text = ws.fk_operator::text;

