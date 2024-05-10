# Add additional DEREFERABLE constraints

ALTER TABLE qgep_od.overflow ADD CONSTRAINT rel_overflow_overflow_to FOREIGN KEY (fk_overflow_to) REFERENCES qgep_od.wastewater_node(obj_id) ON UPDATE CASCADE ON DELETE set null DEFERRABLE INITIALLY DEFERRED;

