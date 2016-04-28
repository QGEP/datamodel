CREATE SCHEMA qgep_conf;

CREATE TABLE qgep_conf.od_reach_replacement_value_parameters (
  clear_height integer,
  depth numeric(7,3),
  replacement_value numeric(10,2),
  PRIMARY KEY (clear_height, depth)
);

COMMENT ON COLUMN qgep_conf.od_reach_replacement_value_parameters.clear_height IS 'Defines the clear_height for which the given replacement_value is defined';
COMMENT ON COLUMN qgep_conf.od_reach_replacement_value_parameters.depth IS 'Defines the depth for which the given replacement_value is defined. The real depth will be rounded up to the first higher value found.';
COMMENT ON COLUMN qgep_conf.od_reach_replacement_value_parameters.replacement_value IS 'The replacement value per m in CHF for the given depth and clear_height';

INSERT INTO qgep_conf.od_reach_replacement_value_parameters
VALUES
  (300, 2.00, 500.00),
  (300, 2.50, 550.00),
  (300, 3.00, 600.00),
  (350, 3.00, 610.00);
