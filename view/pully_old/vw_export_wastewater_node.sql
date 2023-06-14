CREATE OR REPLACE VIEW qgep_sigip.vw_export_wastewater_node AS
  SELECT node.obj_id,
    node.identifier AS identification,
    node_type.value_fr AS type,
    se_type.value_fr AS evac_type,
    material.value_fr AS materiau,
    node.bottom_level AS altitude,
    node.pully_orientation AS orientation,
    node.fk_wastewater_structure AS fk_ws_obj_id,
    node.situation_geometry AS the_geom
  FROM qgep_od.vw_wastewater_node node
    LEFT JOIN qgep_vl.pully_node_bottom_material material ON material.code = node.pully_bottom_material
    LEFT JOIN qgep_vl.pully_node_type node_type on node_type.code = node.pully_node_type
    LEFT JOIN qgep_vl.pully_se_type se_type ON se_type.code = node.pully_se_type
;
