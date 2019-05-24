-- create trigger functions and triggers for quarantine table
CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_structure_update() RETURNS trigger AS $BODY$
DECLARE
  multi_situation_geometry geometry(MULTIPOINTZ,%(SRID)s);
BEGIN
  multi_situation_geometry := st_collect(NEW.situation_geometry)::geometry(MULTIPOINTZ, %(SRID)s);

  -- in case there is a depth, but no refercing value - it should stay in quarantene
  IF( NEW._depth IS NOT NULL AND NEW.co_level IS NULL AND NEW.wn_bottom_level IS NULL ) THEN
    RAISE EXCEPTION 'No referencing value for calculation with depth';
  END IF;

  -- qgep_od.wastewater_structure
  IF( SELECT TRUE FROM qgep_od.vw_qgep_wastewater_structure WHERE obj_id = NEW.obj_id ) THEN
    UPDATE qgep_od.vw_qgep_wastewater_structure SET
    identifier = NEW.identifier,
    situation_geometry = multi_situation_geometry,
    co_shape = NEW.co_shape,
    co_diameter = NEW.co_diameter,
    co_material = NEW.co_material,
    co_positional_accuracy = NEW.co_positional_accuracy,
    co_level =
      (CASE WHEN NEW.co_level IS NULL AND NEW.wn_bottom_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.wn_bottom_level + NEW._depth
      ELSE NEW.co_level
      END),
    _depth = NEW._depth,
    _channel_usage_current = NEW._channel_usage_current,
    ma_material = NEW.ma_material,
    ma_dimension1 = NEW.ma_dimension1,
    ma_dimension2 = NEW.ma_dimension2,
    ws_type = NEW.ws_type,
    ma_function = NEW.ma_function,
    ss_function = NEW.ss_function,
    remark = NEW.remark,
    wn_bottom_level =
      (CASE WHEN NEW.wn_bottom_level IS NULL AND NEW.co_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.co_level - NEW._depth
      ELSE NEW.wn_bottom_level
      END)
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
      (CASE WHEN NEW.co_level IS NULL AND NEW.wn_bottom_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.wn_bottom_level + NEW._depth
      ELSE NEW.co_level
      END),
    NEW._depth,
    NEW._channel_usage_current,
    NEW.ma_material,
    NEW.ma_dimension1,
    NEW.ma_dimension2,
    NEW.ws_type,
    NEW.ma_function,
    NEW.ss_function,
    NEW.remark,
      (CASE WHEN NEW.wn_bottom_level IS NULL AND NEW.co_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.co_level - NEW._depth
      ELSE NEW.wn_bottom_level
      END)
      );
    RAISE NOTICE 'Inserted row in qgep_od.vw_qgep_wastewater_structure';
  END IF;

  -- photo1 insert
  IF (NEW.photo1 IS NOT NULL) THEN
    INSERT INTO qgep_od.file
    (
      object,
      identifier
    )
    VALUES
    (
      NEW.obj_id,
      NEW.photo1
    );
    RAISE NOTICE 'Inserted row in qgep_od.file';
  END IF;

  -- photo2 insert
  IF (NEW.photo2 IS NOT NULL) THEN
    INSERT INTO qgep_od.file
    (
      object,
      identifier
    )
    VALUES
    (
      NEW.obj_id,
      NEW.photo2
    );
    RAISE NOTICE 'Inserted row in qgep_od.file';
  END IF;

  -- set structure okay
  UPDATE qgep_import.manhole_quarantine
  SET structure_okay = true
  WHERE quarantine_serial = NEW.quarantine_serial;
  RETURN NEW;

  -- catch
  EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'EXCEPTION: %%', SQLERRM;
    RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

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
