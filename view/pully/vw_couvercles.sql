CREATE OR REPLACE VIEW qgep_sigip.vw_couvercles AS 
 
  SELECT co.obj_id,
    sp.identifier AS identification,
    material.value_fr AS materiau,
    shape.value_fr AS forme,
    co.diameter AS diametre,
    co.level AS altitude,
    fastening.value_fr AS fixation,
    sp.fk_wastewater_structure AS fk_ws_obj_id,
    co.situation_geometry AS the_geom

  FROM qgep_od.cover co
    LEFT JOIN qgep_od.structure_part sp ON sp.obj_id::text = co.obj_id::text
    LEFT JOIN qgep_vl.cover_material material ON material.code = co.material
    LEFT JOIN qgep_vl.cover_cover_shape shape ON shape.code = co.cover_shape
    LEFT JOiN qgep_vl.cover_fastening fastening ON fastening.code = co.fastening;