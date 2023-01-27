ALTER TABLE qgep_od.file ADD CONSTRAINT rel_file_data_media FOREIGN KEY (fk_data_media) REFERENCES qgep_od.data_media(obj_id) ON UPDATE CASCADE ON DELETE set null;
