
ALTER TABLE qgep_od.wastewater_structure ADD COLUMN fk_main_wastewater_node varchar(16);
ALTER TABLE qgep_od.wastewater_structure ADD CONSTRAINT rel_wastewater_structure_main_wastewater_node FOREIGN KEY (fk_main_wastewater_node) REFERENCES qgep_od.wastewater_node(obj_id) ON UPDATE CASCADE ON DELETE SET NULL;

UPDATE qgep_od.wastewater_structure ws
  SET fk_main_wastewater_node = wn.obj_id
    FROM qgep_od.wastewater_node wn
    LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = wn.obj_id
    WHERE ws.obj_id = ne.fk_wastewater_structure;
