ALTER TABLE qgep.od_maintenance_event ADD COLUMN active_zone VARCHAR(1);
COMMENT ON COLUMN qgep.txt_symbol.class IS 'ID of the active zone, for visualization purpose (use A, B, C, D, E, F, G and H)';
