-- PARTS OF THIS DELTA ALTERING VIEWS/TRIGGERS WERE REMOVED, AS THIS IS NOW DONE IN POST-ALL

-- create schema
CREATE SCHEMA qgep_import;

-- create quarantine table

DROP TABLE IF EXISTS qgep_import.manhole_quarantine CASCADE;

CREATE TABLE qgep_import.manhole_quarantine
(
  obj_id character varying(16),
  identifier character varying(20),
  situation_geometry geometry(Point,%(SRID)s),
  co_shape integer,
  co_diameter smallint,
  co_material integer,
  co_positional_accuracy integer,
  co_level numeric(7,3),
  _depth numeric(6,3),
  _channel_usage_current integer,
  ma_material integer,
  ma_dimension1 smallint,
  ma_dimension2 smallint,
  ws_type text,
  ma_function integer,
  ss_function integer,
  remark character varying(80),
  wn_bottom_level numeric(7,3),
  photo1 text,
  photo2 text,
  inlet_3_material smallint,
  inlet_3_clear_hight numeric(6,3),
  inlet_3_depth_m numeric(6,3),
  inlet_4_material smallint,
  inlet_4_clear_hight numeric(6,3),
  inlet_4_depth_m numeric(6,3),
  inlet_5_material smallint,
  inlet_5_clear_hight numeric(6,3),
  inlet_5_depth_m numeric(6,3),
  inlet_6_material smallint,
  inlet_6_clear_hight numeric(6,3),
  inlet_6_depth_m numeric(6,3),
  inlet_7_material smallint,
  inlet_7_clear_hight numeric(6,3),
  inlet_7_depth_m numeric(6,3),
  outlet_1_material smallint,
  outlet_1_clear_hight numeric(6,3),
  outlet_1_depth_m numeric(6,3),
  outlet_2_material smallint,
  outlet_2_clear_hight numeric(6,3),
  outlet_2_depth_m numeric(6,3),
  structure_okay boolean DEFAULT false,
  inlet_okay boolean DEFAULT false,
  outlet_okay boolean DEFAULT false,
  deleted boolean DEFAULT false,
  quarantine_serial SERIAL PRIMARY KEY
);
