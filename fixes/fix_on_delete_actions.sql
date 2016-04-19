ALTER TABLE qgep.od_cover DROP CONSTRAINT oorel_od_cover_structure_part;
ALTER TABLE qgep.od_cover ADD CONSTRAINT oorel_od_cover_structure_part FOREIGN KEY (obj_id)
      REFERENCES qgep.od_structure_part(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep.od_structure_part DROP CONSTRAINT rel_structure_part_wastewater_structure;
ALTER TABLE qgep.od_structure_part ADD CONSTRAINT rel_structure_part_wastewater_structure FOREIGN KEY (fk_wastewater_structure)
      REFERENCES qgep.od_wastewater_structure(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep.od_manhole DROP CONSTRAINT oorel_od_manhole_wastewater_structure;
ALTER TABLE qgep.od_manhole ADD CONSTRAINT oorel_od_manhole_wastewater_structure FOREIGN KEY (obj_id)
      REFERENCES qgep.od_wastewater_structure(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
      
ALTER TABLE qgep.od_wastewater_node DROP CONSTRAINT oorel_od_wastewater_node_wastewater_networkelement;
ALTER TABLE qgep.od_wastewater_node ADD CONSTRAINT oorel_od_wastewater_node_wastewater_networkelement FOREIGN KEY (obj_id)
      REFERENCES qgep.od_wastewater_networkelement(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep.od_wastewater_networkelement DROP CONSTRAINT rel_wastewater_networkelement_wastewater_structure;
ALTER TABLE qgep.od_wastewater_networkelement ADD CONSTRAINT rel_wastewater_networkelement_wastewater_structure FOREIGN KEY (fk_wastewater_structure)
      REFERENCES qgep.od_wastewater_structure(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

