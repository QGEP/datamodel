ALTER TABLE qgep.od_cover DROP CONSTRAINT oorel_od_cover_structure_part;
ALTER TABLE qgep.od_cover ADD CONSTRAINT oorel_od_cover_structure_part FOREIGN KEY (obj_id)
      REFERENCES qgep.od_structure_part(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep.od_access_aid DROP CONSTRAINT oorel_od_access_aid_structure_part;
ALTER TABLE qgep.od_access_aid ADD CONSTRAINT oorel_od_access_aid_structure_part FOREIGN KEY (obj_id)
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

ALTER TABLE qgep.od_reach_point DROP CONSTRAINT rel_reach_point_wastewater_networkelement;
ALTER TABLE qgep.od_reach_point ADD CONSTRAINT rel_reach_point_wastewater_networkelement FOREIGN KEY (fk_wastewater_networkelement)
      REFERENCES qgep.od_wastewater_networkelement(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE qgep.od_catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_current;
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_current FOREIGN KEY (fk_wastewater_networkelement_rw_current)
      REFERENCES qgep.od_wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE qgep.od_catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_planned;
ALTER TABLE qgep.od_catchment_area ADD  CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_planned FOREIGN KEY (fk_wastewater_networkelement_rw_planned)
      REFERENCES qgep.od_wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE qgep.od_catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_current;
ALTER TABLE qgep.od_catchment_area ADD  CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_current FOREIGN KEY (fk_wastewater_networkelement_ww_current)
      REFERENCES qgep.od_wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE qgep.od_catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_planned;
ALTER TABLE qgep.od_catchment_area ADD  CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_planned FOREIGN KEY (fk_wastewater_networkelement_ww_planned)
      REFERENCES qgep.od_wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
