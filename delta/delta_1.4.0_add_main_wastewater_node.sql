SELECT (NULL); -- Delta already applied manually
/*
ALTER TABLE qgep_od.wastewater_structure ADD COLUMN fk_main_wastewater_node varchar(16);
ALTER TABLE qgep_od.wastewater_structure ADD CONSTRAINT rel_wastewater_structure_main_wastewater_node FOREIGN KEY (fk_main_wastewater_node) REFERENCES qgep_od.wastewater_node(obj_id) ON UPDATE CASCADE ON DELETE SET NULL;

UPDATE qgep_od.wastewater_structure ws
SET fk_main_wastewater_node = wn.wn_obj_id
FROM
(
    SELECT MIN(wn.obj_id) AS wn_obj_id, fk_wastewater_structure
    FROM qgep_od.wastewater_node wn
    LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = wn.obj_id
    GROUP BY fk_wastewater_structure
) AS wn
WHERE wn.fk_wastewater_structure = ws.obj_id;
*/
