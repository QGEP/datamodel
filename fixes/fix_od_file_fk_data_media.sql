-- Modification od_file --> insert fk_data_media

ALTER TABLE qgep.od_file
ADD COLUMN fk_data_media character varying(16);