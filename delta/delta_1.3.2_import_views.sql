-- create trigger functions and triggers for quarantine table
SELECT set_config('qgep.srid', %(SRID)s::text, false);
DO $DO$
BEGIN
EXECUTE format($TRIGGER$
CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_structure_update() RETURNS trigger AS $BODY$
BEGIN

  -- in case there is a depth, but no refercing value - it should stay in quarantene
  IF( NEW._depth IS NOT NULL AND NEW.co_level IS NULL AND NEW.wn_bottom_level IS NULL ) THEN
    RAISE EXCEPTION 'No referencing value for calculation with depth';
  END IF;

  -- qgep_od.wastewater_structure
  IF( SELECT TRUE FROM qgep_od.vw_qgep_wastewater_structure WHERE obj_id = NEW.obj_id ) THEN
    UPDATE qgep_od.vw_qgep_wastewater_structure SET
    identifier = NEW.identifier,
    situation_geometry = ST_Force2D(NEW.situation_geometry),
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
    ST_Force2D(NEW.situation_geometry),
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
    RAISE NOTICE 'EXCEPTION: %%%%', SQLERRM;
    RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;
$TRIGGER$, current_setting('qgep.srid'));
END
$DO$;
