DROP VIEW IF EXISTS qgep_od.vw_reaches_with_blank_connections;


--------
-- View that shows all reaches with blank connections (Blindanschlüsse). Can be used for visualisation
-- Author Urs Kaufmann 19.6.2024
--------

CREATE OR REPLACE VIEW qgep_od.vw_reaches_with_blank_connections AS

SELECT re.obj_id,
re.progression_geometry,
ch.function_hierarchic,
reto.obj_id AS to_obj_id
FROM qgep_od.reach re
LEFT JOIN qgep_od.reach_point rpto ON rpto.obj_id::text = re.fk_reach_point_to::text
LEFT JOIN qgep_od.wastewater_networkelement neto ON neto.obj_id::text = rpto.fk_wastewater_networkelement::text
LEFT JOIN qgep_od.reach reto ON reto.obj_id::text = neto.obj_id::text
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ne.fk_wastewater_structure::text
WHERE reto.obj_id IS NOT NULL;
