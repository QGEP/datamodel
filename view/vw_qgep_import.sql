-- create mobile view

CREATE OR REPLACE VIEW qgep_import.vw_manhole AS
 SELECT DISTINCT ON (ws.obj_id) ws.obj_id,
    ws.identifier,
    ST_Force3D(ws.situation_geometry)::geometry(POINTZ, %(SRID)s) AS situation_geometry,
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
    NULL::text AS photo1,
    NULL::text AS photo2,
    NULL::smallint AS inlet_3_material,
    NULL::integer AS inlet_3_clear_height,
    NULL::numeric(7, 3) AS inlet_3_depth_m,
    NULL::smallint AS inlet_4_material,
    NULL::integer AS inlet_4_clear_height,
    NULL::numeric(7, 3) AS inlet_4_depth_m,
    NULL::smallint AS inlet_5_material,
    NULL::integer AS inlet_5_clear_height,
    NULL::numeric(7, 3) AS inlet_5_depth_m,
    NULL::smallint AS inlet_6_material,
    NULL::integer AS inlet_6_clear_height,
    NULL::numeric(7, 3) AS inlet_6_depth_m,
    NULL::smallint AS inlet_7_material,
    NULL::integer AS inlet_7_clear_height,
    NULL::numeric(7, 3) AS inlet_7_depth_m,
    NULL::smallint AS outlet_1_material,
    NULL::integer AS outlet_1_clear_height,
    NULL::numeric(7, 3) AS outlet_1_depth_m,
    NULL::smallint AS outlet_2_material,
    NULL::integer AS outlet_2_clear_height,
    NULL::numeric(7, 3) AS outlet_2_depth_m,
    FALSE::boolean AS verified,
    (CASE WHEN EXISTS ( SELECT TRUE FROM qgep_import.manhole_quarantine q WHERE q.obj_id = ws.obj_id )
    THEN TRUE
    ELSE FALSE
    END) AS in_quarantine,
    FALSE::boolean AS deleted

   FROM qgep_od.vw_qgep_wastewater_structure ws;


-- create trigger function and trigger for mobile view

CREATE OR REPLACE FUNCTION qgep_import.vw_manhole_insert_into_quarantine_or_delete() RETURNS trigger AS $BODY$
BEGIN
  IF NEW.verified IS TRUE THEN
    IF NEW.deleted IS TRUE THEN
      -- delete this entry
      DELETE FROM qgep_od.vw_qgep_wastewater_structure
      WHERE obj_id = NEW.obj_id;
    ELSE
      -- insert data into quarantine
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
      inlet_3_clear_height,
      inlet_3_depth_m,
      inlet_4_material,
      inlet_4_clear_height,
      inlet_4_depth_m,
      inlet_5_material,
      inlet_5_clear_height,
      inlet_5_depth_m,
      inlet_6_material,
      inlet_6_clear_height,
      inlet_6_depth_m,
      inlet_7_material,
      inlet_7_clear_height,
      inlet_7_depth_m,
      outlet_1_material,
      outlet_1_clear_height,
      outlet_1_depth_m,
      outlet_2_material,
      outlet_2_clear_height,
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
      NEW.inlet_3_clear_height,
      NEW.inlet_3_depth_m,
      NEW.inlet_4_material,
      NEW.inlet_4_clear_height,
      NEW.inlet_4_depth_m,
      NEW.inlet_5_material,
      NEW.inlet_5_clear_height,
      NEW.inlet_5_depth_m,
      NEW.inlet_6_material,
      NEW.inlet_6_clear_height,
      NEW.inlet_6_depth_m,
      NEW.inlet_7_material,
      NEW.inlet_7_clear_height,
      NEW.inlet_7_depth_m,
      NEW.outlet_1_material,
      NEW.outlet_1_clear_height,
      NEW.outlet_1_depth_m,
      NEW.outlet_2_material,
      NEW.outlet_2_clear_height,
      NEW.outlet_2_depth_m
      );
    END IF;
  END IF;
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS on_mutation_make_insert_or_delete ON qgep_import.vw_manhole;

CREATE TRIGGER on_mutation_make_insert_or_delete
  INSTEAD OF INSERT OR UPDATE
  ON qgep_import.vw_manhole
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.vw_manhole_insert_into_quarantine_or_delete();


