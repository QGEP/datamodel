

SET SESSION session_replication_role = replica;


-- TEMPORARY FUNCTION TO HANDLE MISSING COLUMN RENAMES
CREATE FUNCTION pg_temp.handle_missing_column(_source_columns text,
                                              _drop_column bool,
                                              _destination_table_name text,
                                              _destination_column text,
                                              _source_table_name text,
                                              _source_column text default '' )
                                              RETURNS TEXT AS
$func$
DECLARE
  _column_exists int;
BEGIN
  EXECUTE format($$
    SELECT COUNT(*)
      FROM information_schema.columns
      WHERE table_schema ='qgep'
      AND table_name = '%1$I'
      AND column_name = '%2$I'
  $$, _source_table_name, _destination_column ) INTO _column_exists;
  IF _column_exists = 0 THEN
      IF _drop_column THEN
        RAISE NOTICE '%', format('Handle missing column with drop: %1$I.%2$I', _destination_table_name, _destination_column);
        _source_columns := replace(_source_columns, '"'||_destination_column||'"', 'NULL AS '||_destination_column);
      ELSE
        RAISE NOTICE '%', format('Handle missing column rename: %1$I.%2$I to %3$I', _destination_table_name, _source_column, _destination_column);
        _source_columns := replace(_source_columns, _destination_column, _source_column);
      END IF;
      --RAISE NOTICE '%', _source_columns;
  END IF;
  RETURN _source_columns;
END;
$func$ LANGUAGE plpgsql;






DO
$do$
DECLARE
   r record;
   rc int;
   _destination_schema_name text;
   _destination_table_name text;
   _table_exists int;
   _ordered_columns_source text;
   _ordered_columns_dest text;
   _array_pos int;
   _sequence_exists int;
   _sequence_name text;
   _sequence_name_fully_qualified text;
   _sequence_value bigint;
   _loop_count int;
BEGIN
  -- PRIMILARY WORK ON QGEP SCHEMA
  -- alter type from original schema  to new schema to allow further copying
  ALTER TABLE qgep.is_dictionary_od_field ALTER COLUMN field_mandatory TYPE qgep_od.plantype[] USING field_mandatory::text::qgep_od.plantype[];

  -- *******************
  -- COPY TABLES
  FOR r IN
          SELECT table_schema, table_name
          FROM information_schema.tables
          WHERE table_schema = 'qgep' AND table_type = 'BASE TABLE'
          ORDER by table_schema, table_name ASC
  LOOP
    _destination_table_name := regexp_replace(r.table_name,'^(is|vl|od)_','');  -- txt_* tables are in od keep their prefix

    -- Handle missing table in destination (possible renames)
    _loop_count := 0;
    WHILE TRUE LOOP
      EXECUTE format($$
        SELECT COUNT(*)
          FROM information_schema.tables
          WHERE table_schema SIMILAR TO 'qgep_(sys|vl|od)'
          AND table_name = '%1$I'
      $$, _destination_table_name ) INTO _table_exists;
      IF _table_exists = 0 THEN
        -- Handle table renames
        IF _loop_count = 0 THEN
          -- Missing renames
          _destination_table_name := regexp_replace(_destination_table_name,'^hydraulic_characteristic_data','hydraulic_char_data');
          _destination_table_name := regexp_replace(_destination_table_name,'^overflow_characteristic_kind_overflow_characteristic','overflow_char_kind_overflow_characteristic');
          _destination_table_name := regexp_replace(_destination_table_name,'^overflow_characteristic_overflow_characteristic_digital','overflow_char_overflow_characteristic_digital');
          _loop_count = 1;
          CONTINUE;
        END IF;
        IF r.table_name !~ '^vl_' THEN
          RAISE '!!! Table % has no correspondance in new schema', r.table_name;
        ELSE
          RAISE WARNING '!!! Table % has no correspondance in new schema', r.table_name;
        END IF;
        _loop_count = 2;
      END IF;
      EXIT;
    END LOOP;
    IF _loop_count = 2 THEN
      CONTINUE;
    END IF;

    -- get columns in destination table order (if there was some changes)
    EXECUTE format($$
                    SELECT string_agg('"'||column_name||'"',',')
                    FROM (
                      SELECT column_name
                      FROM information_schema.columns
                      WHERE table_name = '%1$I'
                      AND table_schema IN ('qgep_od','qgep_vl','qgep_sys')
                      ORDER BY ordinal_position ASC
                    ) foo;
                  $$, _destination_table_name ) INTO _ordered_columns_dest;

    -- handle missing schema update
    _ordered_columns_source := _ordered_columns_dest;
    IF _destination_table_name IN ('catchment_area_text') THEN
       SELECT pg_temp.handle_missing_column(_ordered_columns_source, FALSE, _destination_table_name, 'fk_catchment_area', r.table_name, 'fk_catchment') INTO _ordered_columns_source;
    END IF;
    IF _destination_table_name IN ('hq_relation', 'hydraulic_char_data', 'overflow') THEN
       SELECT pg_temp.handle_missing_column(_ordered_columns_source, FALSE, _destination_table_name, 'fk_overflow_characteristic', r.table_name, 'fk_overflow_char') INTO _ordered_columns_source;
    END IF;
    IF _destination_table_name IN ('txt_symbol', 'txt_text') THEN
       SELECT pg_temp.handle_missing_column(_ordered_columns_source, TRUE, _destination_table_name, 'fk_wastewater_structure', r.table_name) INTO _ordered_columns_source;
    END IF;
    IF _destination_table_name IN ('txt_text') THEN
      SELECT pg_temp.handle_missing_column(_ordered_columns_source, TRUE, _destination_table_name, 'fk_catchment_area', r.table_name) INTO _ordered_columns_source;
      SELECT pg_temp.handle_missing_column(_ordered_columns_source, TRUE, _destination_table_name, 'fk_reach', r.table_name) INTO _ordered_columns_source;
    END IF;
    IF r.table_name LIKE 'vl_%' THEN
      SELECT pg_temp.handle_missing_column(_ordered_columns_source, TRUE, _destination_table_name, 'value_it', r.table_name) INTO _ordered_columns_source;
      SELECT pg_temp.handle_missing_column(_ordered_columns_source, TRUE, _destination_table_name, 'short_it', r.table_name) INTO _ordered_columns_source;
      SELECT pg_temp.handle_missing_column(_ordered_columns_source, TRUE, _destination_table_name, 'abbr_it', r.table_name) INTO _ordered_columns_source;
    END IF;

    -- Do the copy
    IF r.table_name LIKE 'vl_%' THEN
      _destination_schema_name := 'qgep_vl';
      EXECUTE format('INSERT INTO %1$I.%2$I (%5$s) (SELECT %4$s FROM qgep.%3$I WHERE code > 10000);', _destination_schema_name, _destination_table_name, r.table_name, _ordered_columns_source, _ordered_columns_dest);
      GET DIAGNOSTICS rc = ROW_COUNT;
      RAISE INFO '% %: % elements copied', _destination_schema_name, _destination_table_name, rc;
    ELSIF r.table_name LIKE 'is_%' THEN
      _destination_schema_name := 'qgep_sys';
      IF r.table_name = 'is_logged_actions' THEN
        EXECUTE format('INSERT INTO %1$I.%2$I (%5$s) (SELECT %4$s FROM qgep.%3$I);', _destination_schema_name, _destination_table_name, r.table_name, _ordered_columns_source, _ordered_columns_dest);
        GET DIAGNOSTICS rc = ROW_COUNT;
        RAISE INFO '% %: % elements copied', _destination_schema_name, _destination_table_name, rc;
        SELECT nextval('qgep.is_logged_actions_event_id_seq') INTO _sequence_value;
        PERFORM setval('qgep_sys.logged_actions_event_id_seq', _sequence_value, FALSE);
      ELSIF r.table_name = 'is_oid_prefixes' THEN
        EXECUTE format('INSERT INTO %1$I.%2$I (%5$s) (SELECT %4$s FROM qgep.%3$I WHERE prefix NOT IN (''00000000'',''ch11h8mw'',''ch15z36d'',''ch13p7mz'',''ch176dc9'',''ch17f516'',''ch17nq5g''));', _destination_schema_name, _destination_table_name, r.table_name, _ordered_columns_source, _ordered_columns_dest);
        GET DIAGNOSTICS rc = ROW_COUNT;
        RAISE INFO '% %: % elements copied', _destination_schema_name, _destination_table_name, rc;
        SELECT nextval('qgep.is_oid_prefixes_id_seq') INTO _sequence_value;
        PERFORM setval('qgep_sys.oid_prefixes_id_seq', _sequence_value, FALSE);
      END IF;
    ELSE
      _destination_schema_name := 'qgep_od';
      --EXECUTE format('WITH rows AS ( INSERT INTO %1$I.%2$I (%5$s) (SELECT %4$s FROM qgep.%3$I) RETURNING 1 ) SELECT count(*) FROM rows;', _destination_schema_name, _destination_table_name, r.table_name, _ordered_columns_source, _ordered_columns_dest) INTO rc;
      EXECUTE format('INSERT INTO %1$I.%2$I (%5$s) (SELECT %4$s FROM qgep.%3$I);', _destination_schema_name, _destination_table_name, r.table_name, _ordered_columns_source, _ordered_columns_dest);
      GET DIAGNOSTICS rc = ROW_COUNT;
      RAISE INFO '% %: % elements copied', _destination_schema_name, _destination_table_name, rc;
      _sequence_name := format('seq_%1$I_oid', r.table_name);
      _sequence_name_fully_qualified := format('qgep.%1$I', _sequence_name);
      -- handle renamed sequences
      EXECUTE format($$
        SELECT COUNT(*)
          FROM information_schema.sequences
          WHERE sequence_schema ='qgep'
          AND sequence_name = '%1$I'
      $$, _sequence_name ) INTO _sequence_exists;
      IF _sequence_exists = 0 THEN
        _sequence_name_fully_qualified := replace(_sequence_name_fully_qualified,'qgep.seq_od_hydraulic_char_data_oid','qgep.seq_od_hydraulic_characteristic_data_oid');
        _sequence_name_fully_qualified := replace(_sequence_name_fully_qualified,'qgep.seq_od_overflow_char_oid','qgep.seq_od_overflow_characteristic_oid');
      END IF;
      -- update sequence
      SELECT nextval(_sequence_name_fully_qualified) INTO _sequence_value;
      EXECUTE format('SELECT setval(''%1$I.seq_%2$I_oid'', %3$s, FALSE);', _destination_schema_name, _destination_table_name, _sequence_value);
    END IF;
  END LOOP;
END

$do$;
