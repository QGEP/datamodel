CREATE OR REPLACE VIEW qgep_od.aggregated_wastewater_structure AS
  SELECT ws_1.obj_id,
  st_collect(co.situation_geometry)::geometry(MultiPointZ, :SRID) AS situation_geometry,
  CASE
    WHEN count(wn_1.obj_id) = 1 THEN min(wn_1.obj_id::text)
    ELSE NULL::text
  END AS wn_obj_id
  FROM qgep_od.wastewater_structure ws_1
    FULL JOIN qgep_od.structure_part sp ON sp.fk_wastewater_structure::text = ws_1.obj_id::text
    LEFT JOIN qgep_od.cover co ON co.obj_id::text = sp.obj_id::text
    RIGHT JOIN qgep_od.wastewater_networkelement ne ON ne.fk_wastewater_structure::text = ws_1.obj_id::text
    RIGHT JOIN qgep_od.wastewater_node wn_1 ON wn_1.obj_id::text = ne.obj_id::text
    GROUP BY ws_1.obj_id);

