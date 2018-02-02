

ALTER TABLE qgep_od.damage ADD COLUMN fk_examination varchar (16);
ALTER TABLE qgep_od.damage ADD CONSTRAINT rel_damage_examination FOREIGN KEY (fk_examination) REFERENCES qgep_od.examination(obj_id);
