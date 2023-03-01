-- PARTS OF THIS DELTA ALTERING VIEWS/TRIGGERS WERE REMOVED, AS THIS IS NOW DONE IN POST-ALL

-- change types of quarantene table and rename _hight to _height
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN inlet_3_clear_hight TO inlet_3_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN inlet_4_clear_hight TO inlet_4_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN inlet_5_clear_hight TO inlet_5_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN inlet_6_clear_hight TO inlet_6_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN inlet_7_clear_hight TO inlet_7_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN outlet_1_clear_hight TO outlet_1_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
RENAME COLUMN outlet_2_clear_hight TO outlet_2_clear_height;
ALTER TABLE qgep_import.manhole_quarantine
ALTER COLUMN inlet_3_clear_height TYPE integer,
ALTER COLUMN inlet_3_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_4_clear_height TYPE integer,
ALTER COLUMN inlet_4_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_5_clear_height TYPE integer,
ALTER COLUMN inlet_5_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_6_clear_height TYPE integer,
ALTER COLUMN inlet_6_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_7_clear_height TYPE integer,
ALTER COLUMN inlet_7_depth_m TYPE numeric(7,3),
ALTER COLUMN outlet_1_clear_height TYPE integer,
ALTER COLUMN outlet_1_depth_m TYPE numeric(7,3),
ALTER COLUMN outlet_2_clear_height TYPE integer,
ALTER COLUMN outlet_2_depth_m TYPE numeric(7,3);
