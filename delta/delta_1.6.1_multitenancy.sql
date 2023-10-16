-- Modifications applied for link between object and basket
-------------------------------------------
CREATE TABLE qgep_sys.basket(obj_id varchar(16)
	, prefix_id bigint NOT NULL
	, CONSTRAINT pkey_qgep_sys_basket_obj_id PRIMARY KEY (obj_id));
COMMENT ON TABLE qgep_sys.basket IS 'Table linking ordinary data with corresponding oid-prefix. Not part of the VSA-DSS data model
added solely for TEKSI';
COMMENT ON COLUMN qgep_sys.basket.obj_id IS 'object id of ordinary data';
COMMENT ON COLUMN qgep_sys.basket.prefix_id IS 'id qgep_sys.oid_prefixes, links to the prefix';


-- function for generating StandardOIDs

CREATE OR REPLACE FUNCTION qgep_sys.generate_oid(schema_name text, table_name text, basket integer default NULL)
  RETURNS text AS
$BODY$
DECLARE
  myrec_prefix record;
  myrec_shortcut record;
  myrec_seq record;
BEGIN
  -- first we have to get the OID prefix
  BEGIN
    SELECT id,prefix::text INTO myrec_prefix FROM qgep_sys.oid_prefixes WHERE coalesce(id=basket,active = TRUE);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           RAISE EXCEPTION 'no active record found in table qgep_sys.oid_prefixes';
        WHEN TOO_MANY_ROWS THEN
	   RAISE EXCEPTION 'more than one active records found in table qgep_sys.oid_prefixes';
  END;
  -- test if prefix is of correct length
  IF char_length(myrec_prefix.prefix) != 8 THEN
    RAISE EXCEPTION 'character length of prefix must be 8';
  END IF;
  --get table 2char shortcut
  BEGIN
    SELECT shortcut_en INTO STRICT myrec_shortcut FROM qgep_sys.dictionary_od_table WHERE tablename = table_name;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE EXCEPTION 'dictionary entry for table % not found', table_name;
        WHEN TOO_MANY_ROWS THEN
            RAISE EXCEPTION 'dictonary entry for table % not unique', table_name;
  END;
  --get sequence for table
  EXECUTE format('SELECT nextval(''%1$I.seq_%2$I_oid'') AS seqval', schema_name, table_name) INTO myrec_seq;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'sequence for table % not found', table_name;
  END IF;
  INSERT INTO qgep_sys.basket(obj_id,prefix_id) VALUES(myrec_prefix.id,myrec_prefix.prefix || myrec_shortcut.shortcut_en || to_char(myrec_seq.seqval,'FM000000'));
  RETURN myrec_prefix.prefix || myrec_shortcut.shortcut_en || to_char(myrec_seq.seqval,'FM000000');
END;
$BODY$
  LANGUAGE plpgsql STABLE
  COST 100;


DROP FUNCTION IF EXISTS qgep_sys.generate_oid(text, text);
