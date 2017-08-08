-- Issue #304 - overflow_characteristic - neu overflow_char und hydraulic_characteristic_data - neu hydraulic_char_data

-- 1. Remove CONSTRAINTS
-- ALTER TABLE qgep.od_hq_relation ADD CONSTRAINT rel_hq_relation_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id) ON UPDATE CASCADE ON DELETE cascade;
ALTER TABLE qgep.od_hq_relation DROP CONSTRAINT rel_hq_relation_overflow_characteristic;

-- ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id) ON UPDATE CASCADE ON DELETE set null;
ALTER TABLE qgep.od_overflow DROP CONSTRAINT rel_overflow_overflow_characteristic;

-- ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT rel_hydraulic_characteristic_data_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id) ON UPDATE CASCADE ON DELETE set null;
ALTER TABLE qgep.od_hydraulic_characteristic_data DROP CONSTRAINT rel_hydraulic_characteristic_data_overflow_characteristic;

-- 2. Rename Tables
ALTER TABLE qgep.od_overflow_characteristic RENAME TO od_overflow_char;
ALTER TABLE qgep.od_hydraulic_characteristic_data RENAME TO od_hydraulic_char_data;

-- 3. RENAME fk_ attributes - adapt to fk tablename
ALTER TABLE qgep.od_hydraulic_char_data RENAME COLUMN fk_overflow_characteristic TO fk_overflow_char;
ALTER TABLE qgep.od_hq_relation RENAME COLUMN fk_overflow_characteristic TO fk_overflow_char;
ALTER TABLE qgep.od_overflow RENAME COLUMN fk_overflow_characteristic TO fk_overflow_char;

-- 4. Add CONSTRAINTS again with shortened names rel_from_tablename_to_tablename
ALTER TABLE qgep.od_hq_relation ADD CONSTRAINT rel_hq_relation_overflow_char FOREIGN KEY (fk_overflow_char) REFERENCES qgep.od_overflow_char(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_hydraulic_char_data ADD CONSTRAINT rel_hydraulic_char_data_overflow_char FOREIGN KEY (fk_overflow_char) REFERENCES qgep.od_overflow_char(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_overflow_char FOREIGN KEY (fk_overflow_char) REFERENCES qgep.od_overflow_char(obj_id) ON UPDATE CASCADE ON DELETE set null;


