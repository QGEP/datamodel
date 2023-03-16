ALTER TABLE qgep_od.cover DROP CONSTRAINT oorel_od_cover_structure_part;
ALTER TABLE qgep_od.cover ADD CONSTRAINT oorel_od_cover_structure_part FOREIGN KEY (obj_id)
      REFERENCES qgep_od.structure_part(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep_od.access_aid DROP CONSTRAINT oorel_od_access_aid_structure_part;
ALTER TABLE qgep_od.access_aid ADD CONSTRAINT oorel_od_access_aid_structure_part FOREIGN KEY (obj_id)
      REFERENCES qgep_od.structure_part(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep_od.structure_part DROP CONSTRAINT rel_structure_part_wastewater_structure;
ALTER TABLE qgep_od.structure_part ADD CONSTRAINT rel_structure_part_wastewater_structure FOREIGN KEY (fk_wastewater_structure)
      REFERENCES qgep_od.wastewater_structure(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep_od.manhole DROP CONSTRAINT oorel_od_manhole_wastewater_structure;
ALTER TABLE qgep_od.manhole ADD CONSTRAINT oorel_od_manhole_wastewater_structure FOREIGN KEY (obj_id)
      REFERENCES qgep_od.wastewater_structure(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
      
ALTER TABLE qgep_od.wastewater_node DROP CONSTRAINT oorel_od_wastewater_node_wastewater_networkelement;
ALTER TABLE qgep_od.wastewater_node ADD CONSTRAINT oorel_od_wastewater_node_wastewater_networkelement FOREIGN KEY (obj_id)
      REFERENCES qgep_od.wastewater_networkelement(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep_od.wastewater_networkelement DROP CONSTRAINT rel_wastewater_networkelement_wastewater_structure;
ALTER TABLE qgep_od.wastewater_networkelement ADD CONSTRAINT rel_wastewater_networkelement_wastewater_structure FOREIGN KEY (fk_wastewater_structure)
      REFERENCES qgep_od.wastewater_structure(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE qgep_od.reach_point DROP CONSTRAINT rel_reach_point_wastewater_networkelement;
ALTER TABLE qgep_od.reach_point ADD CONSTRAINT rel_reach_point_wastewater_networkelement FOREIGN KEY (fk_wastewater_networkelement)
      REFERENCES qgep_od.wastewater_networkelement(obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE qgep_od.catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_current;
ALTER TABLE qgep_od.catchment_area ADD CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_current FOREIGN KEY (fk_wastewater_networkelement_rw_current)
      REFERENCES qgep_od.wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE qgep_od.catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_planned;
ALTER TABLE qgep_od.catchment_area ADD  CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_planned FOREIGN KEY (fk_wastewater_networkelement_rw_planned)
      REFERENCES qgep_od.wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE qgep_od.catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_current;
ALTER TABLE qgep_od.catchment_area ADD  CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_current FOREIGN KEY (fk_wastewater_networkelement_ww_current)
      REFERENCES qgep_od.wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE qgep_od.catchment_area DROP CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_planned;
ALTER TABLE qgep_od.catchment_area ADD  CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_planned FOREIGN KEY (fk_wastewater_networkelement_ww_planned)
      REFERENCES qgep_od.wastewater_networkelement (obj_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL;
