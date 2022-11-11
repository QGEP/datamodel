ALTER TABLE qgep_od.reach ADD COLUMN default_coefficient_of_friction  smallint ;
COMMENT ON COLUMN qgep_od.reach.default_coefficient_of_friction IS 'yyy http://www.fsl.orst.edu/geowater/FX3/help/8_Hydraulic_Reference/Mannings_n_Tables.htm /  (1 / N_Manning) value between 0 and 999';
