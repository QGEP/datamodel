-- create mobile view

CREATE OR REPLACE VIEW qgep_import.vw_manhole AS 
 SELECT DISTINCT ON (ws.obj_id) ws.obj_id,
    ws.identifier,
    (st_dump(ws.situation_geometry)).geom::geometry(Point,2056) AS situation_geometry,
    ws.co_shape,
    ws.co_diameter,
    ws.co_material,
    ws.co_positional_accuracy,
    ws.co_level,
    ws._depth::numeric(6, 3) AS _depth,
    ws._channel_usage_current,
    ws.ma_material,
    ws.ma_dimension1,
    ws.ma_dimension2,
    ws.ws_type,
    ws.ma_function,
    ws.ss_function,
    ws.remark,
    ws.wn_bottom_level,
    NULL AS photo1,
    NULL AS photo2,
    NULL::smallint AS inlet_3_material,
    NULL::numeric(6, 3) AS inlet_3_dimension_mm,
    NULL::numeric(6, 3) AS inlet_3_depth_m,
    NULL::smallint AS inlet_4_material,
    NULL::numeric(6, 3) AS inlet_4_dimension_mm,
    NULL::numeric(6, 3) AS inlet_4_depth_m,
    NULL::smallint AS inlet_5_material,
    NULL::numeric(6, 3) AS inlet_5_dimension_mm,
    NULL::numeric(6, 3) AS inlet_5_depth_m,
    NULL::smallint AS inlet_6_material,
    NULL::numeric(6, 3) AS inlet_6_dimension_mm,
    NULL::numeric(6, 3) AS inlet_6_depth_m,
    NULL::smallint AS inlet_7_material,
    NULL::numeric(6, 3) AS inlet_7_dimension_mm,
    NULL::numeric(6, 3) AS inlet_7_depth_m,
    NULL::smallint AS outlet_1_material,
    NULL::numeric(6, 3) AS outlet_1_dimension_mm,
    NULL::numeric(6, 3) AS outlet_1_depth_m,
    NULL::smallint AS outlet_2_material,
    NULL::numeric(6, 3) AS outlet_2_dimension_mm,
    NULL::numeric(6, 3) AS outlet_2_depth_m
   FROM qgep_od.vw_qgep_wastewater_structure ws;


-- create triggerfunction and trigger for mobile view

CREATE OR REPLACE FUNCTION qgep_import.vw_manhole_insert_into_quarantine() RETURNS trigger AS $BODY$
BEGIN
  INSERT INTO qgep_import.manhole_quarantine
  (
  obj_id,
  identifier,
  situation_geometry,
  co_shape,
  co_diameter,
  co_material,
  co_positional_accuracy,
  co_level,
  _depth,
  _channel_usage_current,
  ma_material,
  ma_dimension1,
  ma_dimension2,
  ws_type,
  ma_function,
  ss_function,
  remark,
  wn_bottom_level,
  photo1,
  photo2,
  inlet_3_material,
  inlet_3_dimension_mm,
  inlet_3_depth_m,
  inlet_4_material,
  inlet_4_dimension_mm,
  inlet_4_depth_m,
  inlet_5_material,
  inlet_5_dimension_mm,
  inlet_5_depth_m,
  inlet_6_material,
  inlet_6_dimension_mm,
  inlet_6_depth_m,
  inlet_7_material,
  inlet_7_dimension_mm,
  inlet_7_depth_m,
  outlet_1_material,
  outlet_1_dimension_mm,
  outlet_1_depth_m,
  outlet_2_material,
  outlet_2_dimension_mm,
  outlet_2_depth_m
  )
  VALUES
  (
  NEW.obj_id,
  NEW.identifier,
  NEW.situation_geometry,
  NEW.co_shape,
  NEW.co_diameter,
  NEW.co_material,
  NEW.co_positional_accuracy,
  NEW.co_level,
  NEW._depth,
  NEW._channel_usage_current,
  NEW.ma_material,
  NEW.ma_dimension1,
  NEW.ma_dimension2,
  NEW.ws_type,
  NEW.ma_function,
  NEW.ss_function,
  NEW.remark,
  NEW.wn_bottom_level,
  NEW.photo1,
  NEW.photo2,
  NEW.inlet_3_material,
  NEW.inlet_3_dimension_mm,
  NEW.inlet_3_depth_m,
  NEW.inlet_4_material,
  NEW.inlet_4_dimension_mm,
  NEW.inlet_4_depth_m,
  NEW.inlet_5_material,
  NEW.inlet_5_dimension_mm,
  NEW.inlet_5_depth_m,
  NEW.inlet_6_material,
  NEW.inlet_6_dimension_mm,
  NEW.inlet_6_depth_m,
  NEW.inlet_7_material,
  NEW.inlet_7_dimension_mm,
  NEW.inlet_7_depth_m,
  NEW.outlet_1_material,
  NEW.outlet_1_dimension_mm,
  NEW.outlet_1_depth_m,
  NEW.outlet_2_material,
  NEW.outlet_2_dimension_mm,
  NEW.outlet_2_depth_m   
  );
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS on_mutation_make_insert ON qgep_import.vw_manhole;

CREATE TRIGGER on_mutation_make_insert
  INSTEAD OF INSERT OR UPDATE
  ON qgep_import.vw_manhole
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.vw_manhole_insert_into_quarantine();


-- create quarantine table

DROP TABLE IF EXISTS qgep_import.manhole_quarantine;

CREATE TABLE qgep_import.manhole_quarantine
(
  obj_id character varying(16),
  identifier character varying(20),
  situation_geometry geometry(Point,2056),
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
  inlet_3_dimension_mm numeric(6,3),
  inlet_3_depth_m numeric(6,3),
  inlet_4_material smallint,
  inlet_4_dimension_mm numeric(6,3),
  inlet_4_depth_m numeric(6,3),
  inlet_5_material smallint,
  inlet_5_dimension_mm numeric(6,3),
  inlet_5_depth_m numeric(6,3),
  inlet_6_material smallint,
  inlet_6_dimension_mm numeric(6,3),
  inlet_6_depth_m numeric(6,3),
  inlet_7_material smallint,
  inlet_7_dimension_mm numeric(6,3),
  inlet_7_depth_m numeric(6,3),
  outlet_1_material smallint,
  outlet_1_dimension_mm numeric(6,3),
  outlet_1_depth_m numeric(6,3),
  outlet_2_material smallint,
  outlet_2_dimension_mm numeric(6,3),
  outlet_2_depth_m numeric(6,3),
  structure_okay boolean DEFAULT false,
  inlet_okay boolean DEFAULT false,
  outlet_okay boolean DEFAULT false,
  deleted boolean DEFAULT false,
  quarantine_serial SERIAL PRIMARY KEY
);


-- create triggerfunctions and triggers for mobile view

CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_structure_update() RETURNS trigger AS $BODY$
DECLARE multi_situation_geometry geometry(MultiPoint,2056);
BEGIN
  multi_situation_geometry = st_collect(NEW.situation_geometry)::geometry(MultiPoint,2056);

  -- qgep_od.wastewater_structure
  IF( SELECT TRUE FROM qgep_od.vw_qgep_wastewater_structure WHERE obj_id = NEW.obj_id ) THEN
    UPDATE qgep_od.vw_qgep_wastewater_structure SET
    identifier = NEW.identifier,
    situation_geometry = multi_situation_geometry,
    co_shape = NEW.co_shape,
    co_diameter = NEW.co_diameter,
    co_material = NEW.co_material,
    co_positional_accuracy = NEW.co_positional_accuracy,
    co_level = NEW.co_level,
    _depth = NEW._depth,
    _channel_usage_current = NEW._channel_usage_current,
    ma_material = NEW.ma_material,
    ma_dimension1 = NEW.ma_dimension1,
    ma_dimension2 = NEW.ma_dimension2,
    ws_type = NEW.ws_type,
    ma_function = NEW.ma_function,
    ss_function = NEW.ss_function,
    remark = NEW.remark,
    wn_bottom_level = NEW.wn_bottom_level
    WHERE obj_id = NEW.obj_id;
    RAISE NOTICE 'Updated row in qgep_od.vw_qgep_wastewater_structure';
  ELSE
    INSERT INTO qgep_od.vw_qgep_wastewater_structure
    (
    obj_id,
    identifier,
    situation_geometry,
    co_shape,
    co_diameter,
    co_material,
    co_positional_accuracy,
    co_level,
    _depth,
    _channel_usage_current,
    ma_material,
    ma_dimension1,
    ma_dimension2,
    ws_type,
    ma_function,
    ss_function,
    remark,
    wn_bottom_level
    )
    VALUES
    (
    NEW.obj_id,
    NEW.identifier,
    multi_situation_geometry,
    NEW.co_shape,
    NEW.co_diameter,
    NEW.co_material,
    NEW.co_positional_accuracy,
    NEW.co_level,
    NEW._depth,
    NEW._channel_usage_current,
    NEW.ma_material,
    NEW.ma_dimension1,
    NEW.ma_dimension2,
    NEW.ws_type,
    NEW.ma_function,
    NEW.ss_function,
    NEW.remark,
    NEW.wn_bottom_level
    );
    RAISE NOTICE 'Inserted row in qgep_od.vw_qgep_wastewater_structure';
  END IF;

  -- set structure okay
  UPDATE qgep_import.manhole_quarantine
  SET structure_okay = true
  WHERE quarantine_serial = NEW.quarantine_serial;

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_mutation_try_structure_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_mutation_try_structure_update
  AFTER INSERT OR UPDATE
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  WHEN ( NEW.structure_okay IS NOT TRUE )
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_structure_update();



--


CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_reach_update() RETURNS trigger AS $BODY$
BEGIN
  IF NEW.inlet_okay IS NOT TRUE THEN
    -- try inlet update
    -- set inlet okay
    UPDATE qgep_import.manhole_quarantine
    SET inlet_okay = true
    WHERE quarantine_serial = NEW.quarantene_serial;
  END IF;
  IF NEW.outlet_okay IS NOT TRUE THEN
    -- try outlet update  
    -- set outlet okay
    UPDATE qgep_import.manhole_quarantine
    SET outlet_okay = true
    WHERE quarantine_serial = NEW.quarantene_serial;
  END IF;
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_mutation_try_reach_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_mutation_try_reach_update
  AFTER INSERT OR UPDATE
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  WHEN ( ( NEW.inlet_okay IS NOT TRUE OR NEW.outlet_okay IS NOT TRUE ) AND pg_trigger_depth() = 0 )
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_reach_update();



--


CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_delete_entry() RETURNS trigger AS $BODY$
BEGIN
  DELETE FROM qgep_import.manhole_quarantine
  WHERE quarantine_serial = NEW.quarantine_serial;
  RAISE NOTICE 'Deleted row in qgep_import.manhole_quarantine';
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_mutation_delete_when_okay ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_mutation_delete_when_okay
  AFTER INSERT OR UPDATE
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  WHEN ( NEW.structure_okay IS TRUE AND NEW.inlet_okay IS TRUE AND NEW.outlet_okay IS TRUE )
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_delete_entry();