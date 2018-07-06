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

-- create mobile view

CREATE OR REPLACE VIEW qgep_import.vw_manhole AS 
 SELECT DISTINCT ON (ws.obj_id) ws.obj_id,
    ws.identifier,
    (st_dump(ws.situation_geometry)).geom::geometry(Point,%(SRID)s) AS situation_geometry,
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
    NULL::numeric(6, 3) AS inlet_3_clear_hight,
    NULL::numeric(6, 3) AS inlet_3_depth_m,
    NULL::smallint AS inlet_4_material,
    NULL::numeric(6, 3) AS inlet_4_clear_hight,
    NULL::numeric(6, 3) AS inlet_4_depth_m,
    NULL::smallint AS inlet_5_material,
    NULL::numeric(6, 3) AS inlet_5_clear_hight,
    NULL::numeric(6, 3) AS inlet_5_depth_m,
    NULL::smallint AS inlet_6_material,
    NULL::numeric(6, 3) AS inlet_6_clear_hight,
    NULL::numeric(6, 3) AS inlet_6_depth_m,
    NULL::smallint AS inlet_7_material,
    NULL::numeric(6, 3) AS inlet_7_clear_hight,
    NULL::numeric(6, 3) AS inlet_7_depth_m,
    NULL::smallint AS outlet_1_material,
    NULL::numeric(6, 3) AS outlet_1_clear_hight,
    NULL::numeric(6, 3) AS outlet_1_depth_m,
    NULL::smallint AS outlet_2_material,
    NULL::numeric(6, 3) AS outlet_2_clear_hight,
    NULL::numeric(6, 3) AS outlet_2_depth_m,
    (CASE WHEN EXISTS ( SELECT TRUE FROM qgep_import.manhole_quarantine q WHERE q.obj_id = ws.obj_id )
    THEN TRUE
    ELSE FALSE 
    END) AS in_quarantine

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
  inlet_3_clear_hight,
  inlet_3_depth_m,
  inlet_4_material,
  inlet_4_clear_hight,
  inlet_4_depth_m,
  inlet_5_material,
  inlet_5_clear_hight,
  inlet_5_depth_m,
  inlet_6_material,
  inlet_6_clear_hight,
  inlet_6_depth_m,
  inlet_7_material,
  inlet_7_clear_hight,
  inlet_7_depth_m,
  outlet_1_material,
  outlet_1_clear_hight,
  outlet_1_depth_m,
  outlet_2_material,
  outlet_2_clear_hight,
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
  NEW.inlet_3_clear_hight,
  NEW.inlet_3_depth_m,
  NEW.inlet_4_material,
  NEW.inlet_4_clear_hight,
  NEW.inlet_4_depth_m,
  NEW.inlet_5_material,
  NEW.inlet_5_clear_hight,
  NEW.inlet_5_depth_m,
  NEW.inlet_6_material,
  NEW.inlet_6_clear_hight,
  NEW.inlet_6_depth_m,
  NEW.inlet_7_material,
  NEW.inlet_7_clear_hight,
  NEW.inlet_7_depth_m,
  NEW.outlet_1_material,
  NEW.outlet_1_clear_hight,
  NEW.outlet_1_depth_m,
  NEW.outlet_2_material,
  NEW.outlet_2_clear_hight,
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

-- create triggerfunctions and triggers for quarantine table 
CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_structure_update() RETURNS trigger AS $BODY$
DECLARE 
  multi_situation_geometry geometry(MultiPoint,%(SRID)s);
BEGIN
  multi_situation_geometry = st_collect(NEW.situation_geometry)::geometry(MultiPoint,%(SRID)s);

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

DROP TRIGGER IF EXISTS after_update_try_structure_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_update_try_structure_update
  AFTER UPDATE
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  WHEN ( ( NEW.structure_okay IS NOT TRUE ) 
  AND NOT( OLD.inlet_okay IS NOT TRUE AND NEW.inlet_okay IS TRUE )
  AND NOT( OLD.outlet_okay IS NOT TRUE AND NEW.outlet_okay IS TRUE ) )
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_structure_update();

DROP TRIGGER IF EXISTS after_insert_try_structure_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_insert_try_structure_update
  AFTER INSERT
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_structure_update();

-- Some information:
-- 1. new lets 0 - old lets 0 -> do nothing
-- 2. new lets 0 - old lets 1 -> delete let
-- 3. new lets 0 - old lets n -> delete lets
-- 4. new lets 1 - old lets 0 -> create let (future)
-- 5. new lets 1 - old lets 1 -> update let
-- 6. new lets 1 - old lets n -> manual update needed
-- 7. new lets n - old lets 0 -> create lets (future)
-- 8. new lets n - old lets 1 -> manual update needed
-- 9. new lets n - old lets n -> manual update needed

CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_let_update() RETURNS trigger AS $BODY$
  DECLARE 
    let_kind text;
    new_lets integer;
    old_lets integer;
BEGIN
  let_kind := TG_ARGV[0];

  -- count new lets
  IF let_kind='inlet' AND ( NEW.inlet_3_material IS NOT NULL OR NEW.inlet_3_depth_m IS NOT NULL OR NEW.inlet_3_clear_hight IS NOT NULL ) 
   OR let_kind='outlet' AND ( NEW.outlet_1_material IS NOT NULL OR NEW.outlet_1_depth_m IS NOT NULL OR NEW.outlet_1_clear_hight IS NOT NULL ) THEN
    IF let_kind='inlet' AND ( NEW.inlet_4_material IS NOT NULL OR NEW.inlet_4_depth_m IS NOT NULL OR NEW.inlet_4_clear_hight IS NOT NULL )
     OR let_kind='outlet' AND ( NEW.outlet_2_material IS NOT NULL OR NEW.outlet_2_depth_m IS NOT NULL OR NEW.outlet_2_clear_hight IS NOT NULL ) THEN
      new_lets = 2; -- it's possibly more, but at least > 1
    ELSE
      new_lets = 1;
    END IF;
  ELSE
    new_lets = 0;
  END IF;
  -- count old lets
  old_lets = ( SELECT COUNT (*)
    FROM qgep_od.reach re
    LEFT JOIN qgep_od.reach_point rp ON let_kind='inlet' AND rp.obj_id = re.fk_reach_point_to OR let_kind='outlet' AND rp.obj_id = re.fk_reach_point_from
    LEFT JOIN qgep_od.wastewater_networkelement wn ON wn.obj_id = rp.fk_wastewater_networkelement
    LEFT JOIN qgep_od.vw_qgep_wastewater_structure ws ON ws.obj_id = wn.fk_wastewater_structure
    WHERE ws.obj_id = NEW.obj_id );

  -- handle inlets
  IF ( new_lets > 1 AND old_lets > 0 ) OR old_lets > 1 THEN
    -- request for update because new lets are bigger 1 (and old lets not 0 ) or old lets are bigger 1
    RAISE NOTICE 'Impossible to assign %%s - manual edit needed.', let_kind;
  ELSE
    IF new_lets = 0 AND old_lets > 0 THEN
      -- request for delete because no new lets but old lets
      RAISE NOTICE 'No new %%s but old ones - manual delete needed.', let_kind;
    ELSIF new_lets > 0 AND old_lets = 0 THEN
      -- request for create because no old lets but new lets
      RAISE NOTICE 'No old %%s but new ones - manual create needed.', let_kind;
    ELSE
      IF new_lets = 1 AND old_lets = 1 THEN
        IF let_kind='inlet' THEN
          -- update material and dimension on reach
          UPDATE qgep_od.reach
          SET material = NEW.inlet_3_material,
          clear_height = NEW.inlet_3_clear_hight
          WHERE obj_id = ( SELECT re.obj_id
            FROM qgep_od.reach re
            LEFT JOIN qgep_od.reach_point rp ON rp.obj_id = re.fk_reach_point_to
            LEFT JOIN qgep_od.wastewater_networkelement wn ON wn.obj_id = rp.fk_wastewater_networkelement
            LEFT JOIN qgep_od.vw_qgep_wastewater_structure ws ON ws.obj_id = wn.fk_wastewater_structure
            WHERE ws.obj_id = NEW.obj_id );

          -- update depth_m on reach_point
          UPDATE qgep_od.reach_point
          SET level = NEW.co_level - NEW.inlet_3_depth_m
          WHERE obj_id = ( SELECT rp.obj_id
            FROM qgep_od.reach re
            LEFT JOIN qgep_od.reach_point rp ON rp.obj_id = re.fk_reach_point_to
            LEFT JOIN qgep_od.wastewater_networkelement wn ON wn.obj_id = rp.fk_wastewater_networkelement
            LEFT JOIN qgep_od.vw_qgep_wastewater_structure ws ON ws.obj_id = wn.fk_wastewater_structure
            WHERE ws.obj_id = NEW.obj_id );
        ELSE
          -- update material on reach
          UPDATE qgep_od.reach
          SET material = NEW.outlet_1_material,
          clear_height = NEW.outlet_1_clear_hight
          WHERE obj_id = ( SELECT re.obj_id
            FROM qgep_od.reach re
            LEFT JOIN qgep_od.reach_point rp ON rp.obj_id = re.fk_reach_point_from
            LEFT JOIN qgep_od.wastewater_networkelement wn ON wn.obj_id = rp.fk_wastewater_networkelement
            LEFT JOIN qgep_od.vw_qgep_wastewater_structure ws ON ws.obj_id = wn.fk_wastewater_structure
            WHERE ws.obj_id = NEW.obj_id );

          -- update depth_m on reach_point
          UPDATE qgep_od.reach_point
          SET level = NEW.co_level - NEW.outlet_1_depth_m
          WHERE obj_id = ( SELECT rp.obj_id
            FROM qgep_od.reach re
            LEFT JOIN qgep_od.reach_point rp ON rp.obj_id = re.fk_reach_point_from
            LEFT JOIN qgep_od.wastewater_networkelement wn ON wn.obj_id = rp.fk_wastewater_networkelement
            LEFT JOIN qgep_od.vw_qgep_wastewater_structure ws ON ws.obj_id = wn.fk_wastewater_structure
            WHERE ws.obj_id = NEW.obj_id );
        END IF;

        RAISE NOTICE '%%s updated', let_kind;
      ELSE
        -- do nothing
        RAISE NOTICE 'No %%s - nothing to do', let_kind;
      END IF;     

      IF let_kind='inlet' THEN
        -- set inlet okay
        UPDATE qgep_import.manhole_quarantine
        SET inlet_okay = true
        WHERE quarantine_serial = NEW.quarantine_serial;
      ELSE
        -- set outlet okay
        UPDATE qgep_import.manhole_quarantine
        SET outlet_okay = true
        WHERE quarantine_serial = NEW.quarantine_serial;
      END IF;

    END IF;
  END IF;
  RETURN NEW;

  -- catch
  EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'EXCEPTION: %%', SQLERRM;
    RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_update_try_inlet_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_update_try_inlet_update
  AFTER UPDATE
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  WHEN ( ( NEW.inlet_okay IS NOT TRUE )
  AND NOT( OLD.outlet_okay IS NOT TRUE AND NEW.outlet_okay IS TRUE )
  AND NOT( OLD.structure_okay IS NOT TRUE AND NEW.structure_okay IS TRUE ) )
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_let_update( 'inlet' );

DROP TRIGGER IF EXISTS after_insert_try_inlet_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_insert_try_inlet_update
  AFTER INSERT
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_let_update( 'inlet' );

DROP TRIGGER IF EXISTS after_update_try_outlet_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_update_try_outlet_update
  AFTER UPDATE
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  WHEN ( ( NEW.outlet_okay IS NOT TRUE ) 
  AND NOT( OLD.inlet_okay IS NOT TRUE AND NEW.inlet_okay IS TRUE )
  AND NOT( OLD.structure_okay IS NOT TRUE AND NEW.structure_okay IS TRUE ) )
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_let_update( 'outlet' );

DROP TRIGGER IF EXISTS after_insert_try_outlet_update ON qgep_import.manhole_quarantine;

CREATE TRIGGER after_insert_try_outlet_update
  AFTER INSERT
  ON qgep_import.manhole_quarantine
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.manhole_quarantine_try_let_update( 'outlet' );


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
