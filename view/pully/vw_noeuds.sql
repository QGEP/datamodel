--DROP VIEW IF EXISTS qgep_sigip.vw_noeuds;

CREATE OR REPLACE VIEW qgep_sigip.vw_noeuds AS 
 
  SELECT node.obj_id, 
    ne.identifier AS identification, 
    node_type.value_fr AS type, 
    se_type.value_fr AS evac_type, 
    material.value_fr AS materiau, 
    node.bottom_level AS altitude,
    function_hierarchic.value_fr AS fonction_hierarchique,
    usage_current.value_fr AS genre_utilisation,
    usage_expected.value_fr as usage_attendu,
    node.pully_orientation AS orientation, 
    ne.fk_wastewater_structure AS fk_ws_obj_id,
    node.situation_geometry AS the_geom

  FROM qgep_od.wastewater_node node
    LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = node.obj_id::text
    LEFT JOIN qgep_vl.pully_node_bottom_material material ON material.code = node.pully_bottom_material
    LEFT JOIN qgep_vl.pully_node_type node_type ON node_type.code = node.pully_node_type
    LEFT JOIN qgep_vl.pully_se_type se_type ON se_type.code = node.pully_se_type
    LEFT JOIN qgep_vl.channel_usage_current usage_current ON usage_current.code = node._usage_current
    LEFT JOIN qgep_vl.pully_node_usage_expected usage_expected ON usage_expected.code = node.pully_fk_usage_expected
    LEFT JOIN qgep_vl.channel_function_hierarchic function_hierarchic ON function_hierarchic.code = node._function_hierarchic;