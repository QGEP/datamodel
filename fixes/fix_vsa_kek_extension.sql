

ALTER TABLE qgep.od_damage ADD COLUMN fk_examination varchar (16);
ALTER TABLE qgep.od_damage ADD CONSTRAINT rel_damage_examination FOREIGN KEY (fk_examination) REFERENCES qgep.od_examination(obj_id);
