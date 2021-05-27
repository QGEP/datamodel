
-- table wastewater_node is extended to hold additional attributes necessary for symbology reasons
-- extended attributes are started with an underscore
-- _usage_current is necessary for coloring the wastewater_node symbols
-- _function_hierarchic is necessary for scale-based filtering (display minor wastewater_nodes only at larger scales)

-- TABLE wastewater_node
ALTER TABLE qgep_od.wastewater_node ADD COLUMN _usage_current integer;
COMMENT ON COLUMN qgep_od.wastewater_node._usage_current IS 'not part of the VSA-DSS data model
added solely for QGEP
has to be updated by triggers';
ALTER TABLE qgep_od.wastewater_node ADD COLUMN _function_hierarchic integer;
COMMENT ON COLUMN qgep_od.wastewater_node._function_hierarchic IS 'not part of the VSA-DSS data model
added solely for QGEP
has to be updated by triggers';


--------------------------------------------------------
-- UPDATE wastewater node symbology
-- Argument:
--  * obj_id of wastewater networkelement or NULL to update all
--------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_node_symbology(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
BEGIN

-- Otherwise this will result in very slow query due to on_structure_part_change_networkelement
-- being triggered for all rows. See https://github.com/QGEP/datamodel/pull/166#issuecomment-760245405
IF _all THEN
  RAISE INFO 'Temporarily disabling symbology triggers';
  PERFORM qgep_sys.drop_symbology_triggers();
END IF;

UPDATE qgep_od.wastewater_node n
SET
  _function_hierarchic = function_hierarchic,
  _usage_current = usage_current
FROM(
  SELECT DISTINCT ON (ne.obj_id) ne.obj_id AS ne_obj_id,
      COALESCE(first_value(CH_from.function_hierarchic) OVER w, first_value(CH_to.function_hierarchic) OVER w) AS function_hierarchic,
      COALESCE(first_value(CH_from.usage_current) OVER w, first_value(CH_to.usage_current) OVER w) AS usage_current,
      rank() OVER w AS hierarchy_rank
    FROM
      qgep_od.wastewater_networkelement ne
      LEFT JOIN qgep_od.reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep_od.reach                       re_from           ON re_from.fk_reach_point_from = rp.obj_id
      LEFT JOIN qgep_od.wastewater_networkelement   ne_from           ON ne_from.obj_id = re_from.obj_id
      LEFT JOIN qgep_od.channel                     CH_from           ON CH_from.obj_id = ne_from.fk_wastewater_structure
      LEFT JOIN qgep_vl.channel_function_hierarchic vl_fct_hier_from  ON CH_from.function_hierarchic = vl_fct_hier_from.code
      LEFT JOIN qgep_vl.channel_usage_current       vl_usg_curr_from  ON CH_from.usage_current = vl_usg_curr_from.code
      LEFT JOIN qgep_od.reach                       re_to          ON re_to.fk_reach_point_to = rp.obj_id
      LEFT JOIN qgep_od.wastewater_networkelement   ne_to          ON ne_to.obj_id = re_to.obj_id
      LEFT JOIN qgep_od.channel                     CH_to          ON CH_to.obj_id = ne_to.fk_wastewater_structure
      LEFT JOIN qgep_vl.channel_function_hierarchic vl_fct_hier_to ON CH_to.function_hierarchic = vl_fct_hier_to.code
      LEFT JOIN qgep_vl.channel_usage_current       vl_usg_curr_to ON CH_to.usage_current = vl_usg_curr_to.code
    WHERE _all OR ne.obj_id = _obj_id
      WINDOW w AS ( PARTITION BY ne.obj_id ORDER BY vl_fct_hier_from.order_fct_hierarchic ASC NULLS LAST, vl_fct_hier_to.order_fct_hierarchic ASC NULLS LAST,
                                vl_usg_curr_from.order_usage_current ASC NULLS LAST, vl_usg_curr_to.order_usage_current ASC NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
) symbology_ne
WHERE symbology_ne.ne_obj_id = n.obj_id;

-- See above
IF _all THEN
  RAISE INFO 'Reenabling symbology triggers';
  PERFORM qgep_sys.create_symbology_triggers();
END IF;

END
$BODY$
LANGUAGE plpgsql
VOLATILE;


  -------------------- SYMBOLOGY UPDATE ON CHANNEL TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep_od.ws_symbology_update_by_channel()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_from_id TEXT;
  _ne_from_id TEXT;
  _ws_to_id TEXT;
  _ne_to_id TEXT;
  ch_obj_id TEXT;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      ch_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      ch_obj_id = NEW.obj_id;
    WHEN TG_OP = 'DELETE' THEN
      ch_obj_id = OLD.obj_id;
  END CASE;
  
  BEGIN
    SELECT ws.obj_id, ne.obj_id INTO _ws_from_id, _ne_from_id
      FROM qgep_od.wastewater_networkelement ch_ne
      LEFT JOIN qgep_od.reach re ON ch_ne.obj_id = re.obj_id
      LEFT JOIN qgep_od.reach_point rp ON re.fk_reach_point_from = rp.obj_id
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure = ws.obj_id
      WHERE ch_ne.fk_wastewater_structure = ch_obj_id;
    EXECUTE qgep_od.update_wastewater_structure_symbology(_ws_from_id);
    EXECUTE qgep_od.update_wastewater_node_symbology(_ne_from_id);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- DO NOTHING, THIS CAN HAPPEN
    WHEN TOO_MANY_ROWS THEN
        RAISE EXCEPTION 'TRIGGER ERROR ws_symbology_update_by_channel. Subquery shoud return exactly one row. This is not supposed to happen and indicates an isue with the trigger. The issue must be fixed in QGEP.';
  END;
  
  BEGIN
    SELECT ws.obj_id, ne.obj_id INTO _ws_to_id, _ne_to_id
      FROM qgep_od.wastewater_networkelement ch_ne
      LEFT JOIN qgep_od.reach re ON ch_ne.obj_id = re.obj_id
      LEFT JOIN qgep_od.reach_point rp ON re.fk_reach_point_to = rp.obj_id
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure = ws.obj_id
      WHERE ch_ne.fk_wastewater_structure = ch_obj_id;
    EXECUTE qgep_od.update_wastewater_structure_symbology(_ws_to_id);
    EXECUTE qgep_od.update_wastewater_node_symbology(_ne_to_id);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- DO NOTHING, THIS CAN HAPPEN
    WHEN TOO_MANY_ROWS THEN
        RAISE EXCEPTION 'TRIGGER ERROR ws_symbology_update_by_channel. Subquery shoud return exactly one row. This is not supposed to happen and indicates an isue with the trigger. The issue must be fixed in QGEP.';
  END;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;


  -------------------- SYMBOLOGY UPDATE ON REACH POINT TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep_od.ws_symbology_update_by_reach_point()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_id TEXT;
  _ne_id TEXT;
  rp_obj_id TEXT;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      rp_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      rp_obj_id = NEW.obj_id;
    WHEN TG_OP = 'DELETE' THEN
      rp_obj_id = OLD.obj_id;
  END CASE;

  BEGIN
    SELECT ws.obj_id, ne.obj_id INTO STRICT _ws_id, _ne_id
      FROM qgep_od.wastewater_structure ws
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep_od.reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      WHERE rp.obj_id = rp_obj_id;

    EXECUTE qgep_od.update_wastewater_structure_symbology(_ws_id);
    EXECUTE qgep_od.update_wastewater_node_symbology(_ne_id);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- DO NOTHING, THIS CAN HAPPEN
    WHEN TOO_MANY_ROWS THEN
        RAISE EXCEPTION 'TRIGGER ERROR ws_symbology_update_by_reach_point. Subquery shoud return exactly one row. This is not supposed to happen and indicates an isue with the trigger. The issue must be fixed in QGEP.';
  END;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

  -------------------- SYMBOLOGY UPDATE ON REACH TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep_od.ws_symbology_update_by_reach()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_from_id TEXT;
  _ne_from_id TEXT;
  _ws_to_id TEXT;
  _ne_to_id TEXT;
  symb_attribs RECORD;
  re_obj_id TEXT;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      re_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      re_obj_id = NEW.obj_id;
    WHEN TG_OP = 'DELETE' THEN
      re_obj_id = OLD.obj_id;
  END CASE;

  BEGIN
    SELECT ws.obj_id, ne.obj_id INTO STRICT _ws_from_id, _ne_from_id
      FROM qgep_od.reach re
      LEFT JOIN qgep_od.reach_point rp ON rp.obj_id = re.fk_reach_point_from
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
      WHERE re.obj_id = re_obj_id;
    EXECUTE qgep_od.update_wastewater_structure_symbology(_ws_from_id);
    EXECUTE qgep_od.update_wastewater_node_symbology(_ne_from_id);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- DO NOTHING, THIS CAN HAPPEN
    WHEN TOO_MANY_ROWS THEN
        RAISE EXCEPTION 'TRIGGER ERROR ws_symbology_update_by_reach. Subquery shoud return exactly one row. This is not supposed to happen and indicates an isue with the trigger. The issue must be fixed in QGEP.';
  END;

  BEGIN
    SELECT ws.obj_id, ne.obj_id INTO STRICT _ws_to_id, _ne_to_id
      FROM qgep_od.reach re
      LEFT JOIN qgep_od.reach_point rp ON rp.obj_id = re.fk_reach_point_to
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = ne.fk_wastewater_structure
      WHERE re.obj_id = re_obj_id;
    EXECUTE qgep_od.update_wastewater_structure_symbology(_ws_to_id);
    EXECUTE qgep_od.update_wastewater_node_symbology(_ne_to_id);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- DO NOTHING, THIS CAN HAPPEN
    WHEN TOO_MANY_ROWS THEN
        RAISE EXCEPTION 'TRIGGER ERROR ws_symbology_update_by_reach. Subquery shoud return exactly one row. This is not supposed to happen and indicates an isue with the trigger. The issue must be fixed in QGEP.';
  END;


  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;
