-- Function: qgep.wastewater_structure_symbology_attribs(text)
-- This function allows to determine the function_hierarchic and usage_current of a given wastewater_structure
-- in order to properly style the wastewater_structure.
-- Determination of these attributes is based on the outgoing reaches (ordered by hierarchy) - if any - or incoming reaches
-- if there are no outgoing reaches

-- DROP FUNCTION qgep.wastewater_structure_symbology_attribs(text);

-- NEW return type necessary for the function below

CREATE TYPE qgep.wastewater_structure_symbology_attribs AS
   (function_hierarchic smallint,
    usage_current smallint);

CREATE OR REPLACE FUNCTION qgep.wastewater_structure_symbology_attribs(wastewater_structure_object_id text)
  RETURNS qgep.wastewater_structure_symbology_attribs AS
$BODY$DECLARE
myrec record;
return_vals qgep.wastewater_structure_symbology_attribs;
network_element_obj_id character varying(16);
order_fct_hierarchic smallint := 99;
order_usage_current smallint := 99;
function_hierarchic smallint := NULL;
usage_current smallint := NULL;
BEGIN
-- first get the relevant network_element obj_id
SELECT INTO myrec ne.obj_id
  FROM qgep.od_wastewater_structure ws
  LEFT JOIN qgep.od_wastewater_structure str ON ws.obj_id = str.obj_id
  LEFT JOIN qgep.od_wastewater_networkelement ne ON ne.fk_wastewater_structure = str.obj_id
  WHERE ws.obj_id = wastewater_structure_object_id;
network_element_obj_id := myrec.obj_id;
-- process first only outgoing channels/reaches
-- need to process multiple outgoing reaches in order of function_hierarchic and usage_current
FOR myrec
  IN SELECT
    channel_from.function_hierarchic,
    vl_fct_hier.order_fct_hierarchic,
    channel_from.usage_current,
    vl_usg_curr.order_usage_current
    FROM qgep.od_wastewater_networkelement ne
    LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
    LEFT JOIN qgep.od_reach re_from ON re_from.fk_reach_point_from = rp.obj_id
    LEFT JOIN qgep.od_wastewater_networkelement ne_from ON ne_from.obj_id = re_from.obj_id
    LEFT JOIN qgep.od_wastewater_structure struct_from ON ne_from.fk_wastewater_structure = struct_from.obj_id
    LEFT JOIN qgep.od_channel channel_from ON channel_from.obj_id = struct_from.obj_id
    LEFT JOIN qgep.vl_channel_function_hierarchic vl_fct_hier ON channel_from.function_hierarchic = vl_fct_hier.code
    LEFT JOIN qgep.vl_channel_usage_current vl_usg_curr ON channel_from.usage_current = vl_usg_curr.code
    WHERE ne.obj_id = network_element_obj_id AND channel_from.function_hierarchic IS NOT NULL
    AND channel_from.usage_current IS NOT NULL
    ORDER BY vl_fct_hier.order_fct_hierarchic ASC, vl_usg_curr.order_usage_current ASC
LOOP
  IF myrec.order_fct_hierarchic IS NOT NULL AND myrec.order_usage_current IS NOT NULL THEN
	IF myrec.order_fct_hierarchic <= order_fct_hierarchic THEN
		order_fct_hierarchic := myrec.order_fct_hierarchic;
		function_hierarchic := myrec.function_hierarchic;
		IF myrec.order_usage_current <= order_usage_current THEN
			order_usage_current := myrec.order_usage_current;
			usage_current := myrec.usage_current;
		END IF;
	END IF;
  END IF;
END LOOP;
-- in case there is no outgoing channel/reach we need to examine incoming reaches
IF function_hierarchic IS NULL THEN
  FOR myrec
    IN SELECT
	  channel_to.function_hierarchic,
	  vl_fct_hier.order_fct_hierarchic,
	  channel_to.usage_current,
	  vl_usg_curr.order_usage_current
      FROM qgep.od_wastewater_networkelement ne
      LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep.od_reach re_to ON re_to.fk_reach_point_to = rp.obj_id
      LEFT JOIN qgep.od_wastewater_networkelement ne_to ON ne_to.obj_id = re_to.obj_id
      LEFT JOIN qgep.od_wastewater_structure struct_to ON ne_to.fk_wastewater_structure = struct_to.obj_id
      LEFT JOIN qgep.od_channel channel_to ON channel_to.obj_id = struct_to.obj_id
      LEFT JOIN qgep.vl_channel_function_hierarchic vl_fct_hier ON channel_to.function_hierarchic = vl_fct_hier.code
      LEFT JOIN qgep.vl_channel_usage_current vl_usg_curr ON channel_to.usage_current = vl_usg_curr.code
      WHERE ne.obj_id = network_element_obj_id
      AND channel_to.function_hierarchic IS NOT NULL
      AND channel_to.usage_current IS NOT NULL
      ORDER BY vl_fct_hier.order_fct_hierarchic ASC, vl_usg_curr.order_usage_current ASC
  LOOP
    IF myrec.order_fct_hierarchic IS NOT NULL AND myrec.order_usage_current IS NOT NULL THEN
	IF myrec.order_fct_hierarchic <= order_fct_hierarchic THEN
		order_fct_hierarchic := myrec.order_fct_hierarchic;
		function_hierarchic := myrec.function_hierarchic;
		IF myrec.order_usage_current <= order_usage_current THEN
			order_usage_current := myrec.order_usage_current;
			usage_current := myrec.usage_current;
		END IF;
	END IF;
    END IF;
  END LOOP;
END IF;
return_vals.function_hierarchic := function_hierarchic;
return_vals.usage_current := usage_current;
RETURN return_vals;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


  -------------------- SYMBOLOGY UPDATE ON CHANNEL TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep.ws_symbology_update_by_channel()
  RETURNS trigger AS
$BODY$
DECLARE
  ws_obj_id RECORD;
  symb_attribs RECORD;
  affected_obj_ids TEXT[];
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      affected_obj_ids = ARRAY[NEW.obj_id, OLD.obj_id];
    WHEN TG_OP = 'INSERT' THEN
      affected_obj_ids = ARRAY[NEW.obj_id];
    WHEN TG_OP = 'DELETE' THEN
      affected_obj_ids = ARRAY[OLD.obj_id];
  END CASE;

  FOR ws_obj_id IN
    SELECT ws.obj_id
      FROM qgep.od_wastewater_structure ws
      LEFT JOIN qgep.od_wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep.od_reach re ON (re.fk_reach_point_from = rp.obj_id OR re.fk_reach_point_to = rp.obj_id )
      LEFT JOIN qgep.od_wastewater_networkelement rene ON rene.obj_id = re.obj_id
      WHERE rene.fk_wastewater_structure = ANY ( affected_obj_ids )
  LOOP
      SELECT * FROM qgep.wastewater_structure_symbology_attribs( ws_obj_id.obj_id  )
        INTO symb_attribs;
      UPDATE qgep.od_wastewater_structure
      SET
        _usage_current = symb_attribs.usage_current,
        _function_hierarchic = symb_attribs.function_hierarchic
      WHERE
        obj_id = ws_obj_id.obj_id;

      -- RAISE NOTICE 'Updating wastewater_structure (%, %)', ws_obj_id.obj_id, symb_attribs.usage_current;
  END LOOP;
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

DROP TRIGGER IF EXISTS ws_symbology_update_by_channel ON qgep.od_channel;

CREATE TRIGGER ws_symbology_update_by_channel
  AFTER INSERT OR UPDATE OR DELETE
  ON qgep.od_channel
  FOR EACH ROW
  EXECUTE PROCEDURE qgep.ws_symbology_update_by_channel();

  -------------------- SYMBOLOGY UPDATE ON REACH POINT TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep.ws_symbology_update_by_reach_point()
  RETURNS trigger AS
$BODY$
DECLARE
  ws_obj_id RECORD;
  symb_attribs RECORD;
  affected_obj_ids TEXT[];
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      affected_obj_ids = ARRAY[NEW.obj_id, OLD.obj_id];
    WHEN TG_OP = 'INSERT' THEN
      affected_obj_ids = ARRAY[NEW.obj_id];
    WHEN TG_OP = 'DELETE' THEN
      affected_obj_ids = ARRAY[OLD.obj_id];
  END CASE;

  FOR ws_obj_id IN
    SELECT ws.obj_id
      FROM qgep.od_wastewater_structure ws
      LEFT JOIN qgep.od_wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      WHERE rp.obj_id = ANY ( affected_obj_ids )
  LOOP
    SELECT * FROM qgep.wastewater_structure_symbology_attribs( ws_obj_id.obj_id  )
        INTO symb_attribs;
      UPDATE qgep.od_wastewater_structure
      SET
        _usage_current = symb_attribs.usage_current,
        _function_hierarchic = symb_attribs.function_hierarchic
      WHERE
        obj_id = ws_obj_id.obj_id;

      -- RAISE NOTICE 'Updating wastewater_structure (%, %)', ws_obj_id.obj_id, symb_attribs.usage_current;
  END LOOP;
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

  DROP TRIGGER IF EXISTS ws_symbology_update_by_reach_point ON qgep.od_reach_point;

-- only update -> insert and delete are handled by reach trigger
CREATE TRIGGER ws_symbology_update_by_reach_point
  AFTER UPDATE
    ON qgep.od_reach_point
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_symbology_update_by_reach_point();


  -------------------- SYMBOLOGY UPDATE ON REACH TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep.ws_symbology_update_by_reach()
  RETURNS trigger AS
$BODY$
DECLARE
  ws_obj_id RECORD;
  symb_attribs RECORD;
  affected_obj_ids TEXT[];
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      affected_obj_ids = ARRAY[NEW.obj_id, OLD.obj_id];
    WHEN TG_OP = 'INSERT' THEN
      affected_obj_ids = ARRAY[NEW.obj_id];
    WHEN TG_OP = 'DELETE' THEN
      affected_obj_ids = ARRAY[OLD.obj_id];
  END CASE;

  FOR ws_obj_id IN
    SELECT ws.obj_id
      FROM qgep.od_wastewater_structure ws
      LEFT JOIN qgep.od_wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep.od_reach re ON ( rp.obj_id = re.fk_reach_point_from OR rp.obj_id = re.fk_reach_point_to )
      WHERE re.obj_id = ANY ( affected_obj_ids )
  LOOP
    SELECT * FROM qgep.wastewater_structure_symbology_attribs( ws_obj_id.obj_id  )
      INTO symb_attribs;
    UPDATE qgep.od_wastewater_structure
    SET
      _usage_current = symb_attribs.usage_current,
      _function_hierarchic = symb_attribs.function_hierarchic
    WHERE
      obj_id = ws_obj_id.obj_id;

      -- RAISE NOTICE 'Updating wastewater_structure (%, %)', ws_obj_id.obj_id, symb_attribs.usage_current;
  END LOOP;
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

DROP TRIGGER IF EXISTS ws_symbology_update_by_reach ON qgep.od_reach;

CREATE TRIGGER ws_symbology_update_by_reach
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep.od_reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_symbology_update_by_reach();











































--------------------------------------------------------
-- UPDATE wastewater structure label
-- Argument:
--  * obj_id of wastewater structure or NULL to update all
-- 
--------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.update_wastewater_structure_label(_obj_id text)
  RETURNS VOID AS
  $BODY$

UPDATE qgep.od_wastewater_structure ws
SET _label = label
FROM (
  SELECT ws_obj_id,
       array_to_string(
         array_agg( 'C' || '=' || co_level::text ORDER BY co_level DESC),
         E'\n'
       ) ||
       E'\n' ||
       ws_identifier || 
       E'\n' ||
       array_to_string(
         array_agg(
           io || 
             CASE 
               WHEN io='I' THEN i_index 
               ELSE o_index 
             END  || '⁼' || 
             COALESCE(round(level, 2)::text, 'N/A')
           ORDER BY io='O' ASC NULLS LAST, CASE WHEN io = 'I' THEN i_index ELSE o_index END)
           , E'\n'
         ) AS label
  FROM (
    SELECT SP.identifier AS co_identifier,
           CO.obj_id,
           CO.level AS co_level,
           WS.obj_id AS ws_obj_id,
           WS.identifier AS ws_identifier,
           RP.obj_id,
           RP.level,
           RE_from.obj_id,
           RE_to.obj_id,
           CASE 
             WHEN RE_to.obj_id IS NOT NULL THEN 'I' 
             WHEN RE_from.obj_id IS NOT NULL THEN 'O'
             ELSE NULL 
           END AS io,
           row_number() OVER(
             PARTITION BY WS.obj_id
             ORDER BY ST_Azimuth(RP.situation_geometry,ST_LineInterpolatePoint(ST_GeometryN(RE_to.progression_geometry,1),0.99))/pi()*180 ASC) AS i_index,
           row_number() OVER(
             PARTITION BY WS.obj_id
             ORDER BY ST_Azimuth(RP.situation_geometry,ST_LineInterpolatePoint(ST_GeometryN(RE_from.progression_geometry,1),0.99))/pi()*180 ASC) AS o_index
    FROM qgep.od_wastewater_structure WS
    LEFT JOIN qgep.od_wastewater_networkelement NE ON NE.fk_wastewater_structure = WS.obj_id
    LEFT JOIN qgep.od_reach_point RP ON RP.fk_wastewater_networkelement = NE.obj_id
    LEFT JOIN qgep.od_reach RE_from ON RP.obj_id = RE_from.fk_reach_point_from
    LEFT JOIN qgep.od_reach RE_to ON RP.obj_id = RE_to.fk_reach_point_to
    LEFT JOIN qgep.od_structure_part SP on SP.fk_wastewater_structure = WS.obj_id
    LEFT JOIN qgep.od_cover CO ON CO.obj_id = SP.obj_id
  ) AS c
  GROUP BY ws_identifier, ws_obj_id
) sq
WHERE ws_obj_id = ws.obj_id AND CASE WHEN _obj_id IS NULL THEN TRUE ELSE obj_id = _obj_id END
$BODY$
LANGUAGE sql
VOLATILE;

--------------------------------------------------
-- ON COVER CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.ws_label_update_by_cover()
  RETURNS trigger AS
$BODY$
DECLARE
  co_obj_id TEXT;
  affected_sp RECORD;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      co_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      co_obj_id = NEW.obj_id;
    WHEN TG_OP = 'DELETE' THEN
      co_obj_id = OLD.obj_id;
  END CASE;

  SELECT SP.fk_wastewater_structure INTO affected_sp
  FROM qgep.od_structure_part SP
  WHERE obj_id = co_obj_id;

  EXECUTE qgep.update_wastewater_structure_label(affected_sp.fk_wastewater_structure);
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;




--------------------------------------------------
-- ON STRUCTURE PART / NETWORKELEMENT CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.ws_label_update_by_structure_part_networkelement()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_obj_ids TEXT[];
  _ws_obj_id TEXT;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      _ws_obj_ids = ARRAY[OLD.fk_wastewater_structure, NEW.fk_wastewater_structure];
    WHEN TG_OP = 'INSERT' THEN
      _ws_obj_ids = ARRAY[NEW.fk_wastewater_structure];
    WHEN TG_OP = 'DELETE' THEN
      _ws_obj_ids = ARRAY[OLD.fk_wastewater_structure];
  END CASE;

  FOREACH _ws_obj_id IN ARRAY _ws_obj_ids
  LOOP
    EXECUTE qgep.update_wastewater_structure_label(_ws_obj_id);
  END LOOP;
  
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;



--------------------------------------------------
-- ON WASTEWATER STRUCTURE CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.ws_label_update_by_wastewater_structure()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_obj_id TEXT;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      -- Prevent recursion
      IF OLD.identifier = NEW.identifier THEN
        RETURN NEW;
      END IF;
      _ws_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      _ws_obj_id = NEW.obj_id;
  END CASE;
  SELECT qgep.update_wastewater_structure_label(_ws_obj_id) INTO NEW._label;

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;

--------------------------------------------------
-- ON REACH CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.ws_label_update_by_reach()
  RETURNS trigger AS
$BODY$
DECLARE
  rp_obj_ids TEXT[];
  _ws_obj_id TEXT;
  rps RECORD;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      rp_obj_ids = ARRAY[OLD.fk_reach_point_from, OLD_fk_reach_point_to];
    WHEN TG_OP = 'INSERT' THEN
      rp_obj_ids = ARRAY[NEW.fk_reach_point_from, NEW_fk_reach_point_to];
    WHEN TG_OP = 'DELETE' THEN
      rp_obj_ids = ARRAY[OLD.fk_reach_point_from, OLD_fk_reach_point_to];
  END CASE;

  FOR _ws_obj_id IN
    SELECT ws.obj_id
      FROM qgep.od_wastewater_structure ws
      LEFT JOIN qgep.od_wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      WHERE rp.obj_id = ANY ( rp_obj_ids )
  LOOP
    EXECUTE qgep.update_wastewater_structure_label(_ws_obj_id);
  END LOOP;
  
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;

--------------------------------------------------
-- ON REACH POINT CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.ws_label_update_by_reach_point()
  RETURNS trigger AS
$BODY$
DECLARE
  rp_obj_id TEXT;
  _ws_obj_id TEXT;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      rp_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      rp_obj_id = NEW.obj_id;
    WHEN TG_OP = 'DELETE' THEN
      rp_obj_id = OLD.obj_id;
  END CASE;

  SELECT ws.obj_id INTO _ws_obj_id
  FROM qgep.od_wastewater_structure ws
  LEFT JOIN qgep.od_wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
  LEFT JOIN qgep.od_reach_point rp ON ne.obj_id = rp_obj_id;
  
  EXECUTE qgep.update_wastewater_structure_label(_ws_obj_id);

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;

-----------------------------------------------------------------------
-- Drop Symbology Triggers
-- To temporarily disable these cache refreshes for batch jobs like migrations
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.drop_symbology_triggers() RETURNS VOID AS $$
BEGIN
  DROP TRIGGER IF EXISTS ws_label_update_by_reach_point ON qgep.od_reach_point;
  DROP TRIGGER IF EXISTS ws_label_update_by_reach ON qgep.od_reach;
  DROP TRIGGER IF EXISTS ws_label_update_by_wastewater_structure ON qgep.od_wastewater_structure;
  DROP TRIGGER IF EXISTS ws_label_update_by_wastewater_networkelement ON qgep.od_wastewater_networkelement;
  DROP TRIGGER IF EXISTS ws_label_update_by_structure_part ON qgep.od_structure_part;
  DROP TRIGGER IF EXISTS ws_label_update_by_cover ON qgep.od_cover;
  RETURN;
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- Create Symbology Triggers
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.create_symbology_triggers() RETURNS VOID AS $$
BEGIN
  CREATE TRIGGER ws_label_update_by_reach_point
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep.od_reach_point
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_label_update_by_reach_point();

  CREATE TRIGGER ws_label_update_by_reach
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep.od_reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_label_update_by_reach();

  CREATE TRIGGER ws_label_update_by_wastewater_structure
  AFTER INSERT OR UPDATE
    ON qgep.od_wastewater_structure
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_label_update_by_wastewater_structure();

  CREATE TRIGGER ws_label_update_by_wastewater_networkelement
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep.od_wastewater_networkelement
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_label_update_by_structure_part_networkelement();

  CREATE TRIGGER ws_label_update_by_structure_part
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep.od_structure_part
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_label_update_by_structure_part_networkelement();

  CREATE TRIGGER ws_label_update_by_cover
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep.od_cover
  FOR EACH ROW
    EXECUTE PROCEDURE qgep.ws_label_update_by_cover();

  RETURN;
END;
$$ LANGUAGE plpgsql;