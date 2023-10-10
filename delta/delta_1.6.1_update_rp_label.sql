COMMENT ON COLUMN qgep_od.wastewater_structure._usage_current IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';

COMMENT ON COLUMN qgep_od.wastewater_structure._function_hierarchic IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';

COMMENT ON COLUMN qgep_od.manhole._orientation IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater';


--drop unnecessary labels
ALTER TABLE qgep_od.wastewater_structure DROP COLUMN IF EXISTS _label ;
ALTER TABLE qgep_od.wastewater_structure DROP COLUMN IF EXISTS _cover_label ;
ALTER TABLE qgep_od.wastewater_structure DROP COLUMN IF EXISTS _input_label ;
ALTER TABLE qgep_od.wastewater_structure DROP COLUMN IF EXISTS _output_label ;
ALTER TABLE qgep_od.wastewater_structure DROP COLUMN IF EXISTS _bottom_label ;

-- TABLE wastewater_node

COMMENT ON COLUMN qgep_od.wastewater_node._usage_current IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';

COMMENT ON COLUMN qgep_od.wastewater_node._function_hierarchic IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';

COMMENT ON COLUMN qgep_od.wastewater_node._status IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';



CREATE TABLE IF NOT EXISTS qgep_od.labels
(
obj_id character varying(16) COLLATE pg_catalog."default" NOT NULL,
    _label text COLLATE pg_catalog."default",
    _cover_label text COLLATE pg_catalog."default",
    _input_label text COLLATE pg_catalog."default",
    _output_label text COLLATE pg_catalog."default",
    _bottom_label text COLLATE pg_catalog."default",
	CONSTRAINT pkey_qgep_od_labels_obj_id PRIMARY KEY (obj_id)
);

COMMENT ON TABLE qgep_od.labels IS 'stores all labels. not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';
-------------
-- Reach point label config
------------

-- this column is an extension to the VSA data model and defines whether connected channels are included in inflow/outflow labeling based on function_hierarchic
ALTER TABLE qgep_vl.channel_function_hierarchic ADD COLUMN include_in_ws_labels boolean DEFAULT FALSE;
UPDATE qgep_vl.channel_function_hierarchic SET include_in_ws_labels=TRUE WHERE code=ANY('{5062,5064,5066,5068,5069,5070,5071,5072,5074}');


-- this column is an extension to the VSA data model and defines whether connected channels are included in inflow/outflow labeling based on function_hierarchic
ALTER TABLE qgep_vl.wastewater_structure_status ADD COLUMN include_in_ws_labels boolean DEFAULT FALSE;
UPDATE qgep_vl.wastewater_structure_status SET include_in_ws_labels=TRUE WHERE code=ANY('{8493,6530,6533}');

-------------
-- Reach point label
------------

CREATE OR REPLACE FUNCTION qgep_od.update_reach_point_label(_obj_id text, 
	_all boolean default false
	)
  RETURNS VOID AS
 $BODY$
  DECLARE
  _labeled_ws_status bigint[] ;
  _labeled_ch_func_hier bigint[]; 
  BEGIN
  -- Updates the reach_point labels of the wastewater_structure 
  -- _obj_id: obj_id of the associatied wastewater structure
  -- _all: optional boolean to update all reach points
  -- _labeled_ws_status: codes of the ws_status to be labeled. Default: Array of operational.xxx
  -- _labeled_ch_func_hier: codes of the ch_function_hierarchic to be labeled. Default: Array of pwwf.xxx

-- check value lists for label inclusion
SELECT array_agg(code) INTO _labeled_ws_status
FROM qgep_vl.wastewater_structure_status
WHERE include_in_ws_labels;
	  
SELECT array_agg(code) INTO _labeled_ch_func_hier
FROM qgep_vl.channel_function_hierarchic
WHERE include_in_ws_labels; 
	
    with  
	--outputs
	outp as( SELECT
    ne.fk_wastewater_structure
    , rp.obj_id
	, ST_Azimuth(rp.situation_geometry,ST_PointN(re.progression_geometry,2)) as azimuth			
    , row_number() OVER(PARTITION BY NE.fk_wastewater_structure 
					ORDER BY vl_fh.order_fct_hierarchic,vl_uc.order_usage_current,ST_Azimuth(rp.situation_geometry,ST_PointN(ST_CurveToLine(re.progression_geometry),2))/pi()*180 ASC) 
					as idx
    , count	(*) OVER(PARTITION BY NE.fk_wastewater_structure ) as max_idx				
      FROM qgep_od.reach_point rp
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      INNER JOIN qgep_od.reach re ON rp.obj_id = re.fk_reach_point_from
      LEFT JOIN qgep_od.wastewater_networkelement ne_re ON ne_re.obj_id = re.obj_id
      LEFT JOIN qgep_od.channel ch ON ne_re.fk_wastewater_structure = ch.obj_id
	  LEFT JOIN qgep_od.wastewater_structure ws ON ne_re.fk_wastewater_structure = ws.obj_id
	  LEFT JOIN qgep_vl.channel_function_hierarchic vl_fh ON vl_fh.code = ch.function_hierarchic
	  LEFT JOIN qgep_vl.channel_usage_current vl_uc ON vl_uc.code = ch.usage_current
	  WHERE ch.function_hierarchic= ANY(_labeled_ch_func_hier) 
			AND ws.status = ANY(_labeled_ws_status) 
		    AND ((_all AND ne.fk_wastewater_structure IS NOT NULL) 
			  OR ne.fk_wastewater_structure= _obj_id)) ,
	
	--inputs
	inp as( SELECT
    ne.fk_wastewater_structure
    , rp.obj_id
    , row_number() OVER(PARTITION BY NE.fk_wastewater_structure 
					ORDER BY (mod((((ST_Azimuth(rp.situation_geometry
												,ST_PointN(ST_CurveToLine(re.progression_geometry),-2)
											   )
									 - coalesce(o.azimuth,0))/pi()*180)+360)::numeric
								  ,360::numeric)
							 ) ASC
					   ) 
					as idx
    , count	(*) OVER(PARTITION BY NE.fk_wastewater_structure ) as max_idx				
      FROM qgep_od.reach_point rp
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      INNER JOIN qgep_od.reach re ON rp.obj_id = re.fk_reach_point_to
      LEFT JOIN qgep_od.wastewater_networkelement ne_re ON ne_re.obj_id = re.obj_id
      LEFT JOIN qgep_od.channel ch ON ne_re.fk_wastewater_structure = ch.obj_id
	  LEFT JOIN qgep_od.wastewater_structure ws ON ne_re.fk_wastewater_structure = ws.obj_id
	  LEFT JOIN outp o on o.fk_wastewater_structure=ne.fk_wastewater_structure AND o.idx=1
	  WHERE ch.function_hierarchic= ANY(_labeled_ch_func_hier) 
			AND ws.status = ANY(_labeled_ws_status) 
		    AND ((_all AND ne.fk_wastewater_structure IS NOT NULL) 
			  OR ne.fk_wastewater_structure= _obj_id)),	
  
  -- non-labeled rp
  null_label as(
     SELECT
    ne.fk_wastewater_structure
    , rp.obj_id		
      FROM qgep_od.reach_point rp
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      INNER JOIN qgep_od.reach re ON rp.obj_id IN(re.fk_reach_point_to,re.fk_reach_point_from)
      LEFT JOIN qgep_od.wastewater_networkelement ne_re ON ne_re.obj_id = re.obj_id
      LEFT JOIN qgep_od.channel ch ON ne_re.fk_wastewater_structure = ch.obj_id
	  LEFT JOIN qgep_od.wastewater_structure ws ON ne_re.fk_wastewater_structure = ws.obj_id
	  WHERE NOT(ch.function_hierarchic = ANY(_labeled_ch_func_hier) 
			AND ws.status = ANY(_labeled_ws_status))
		    AND ((_all AND ne.fk_wastewater_structure IS NOT NULL) 
			  OR ne.fk_wastewater_structure= _obj_id)),
  
  -- actual labels  
  rp_label as 
  (
  SELECT 'I'||CASE WHEN max_idx=1 THEN '' ELSE idx::text END as new_label
  , obj_id
  FROM inp
  UNION
  SELECT 'O'||CASE WHEN max_idx=1 THEN '' ELSE idx::text END as new_label
  , obj_id
  FROM outp 
  UNION
  SELECT NULL as new_label
  , obj_id
  FROM null_label)
 --Upsert reach_point labels 
  INSERT INTO qgep_od.labels (obj_id,_label) 
  SELECT  rp_label.obj_id,rp_label.new_label
  FROM rp_label
  ON CONFLICT (obj_id) DO 
  UPDATE SET _label = EXCLUDED._label ;
  
END;
$BODY$
LANGUAGE plpgsql
VOLATILE;


--------------------------------------------------
-- ON REACH POINT CHANGE
--------------------------------------------------

-- 8.9.2023 ADD "EXECUTE qgep_od.update_reach_point_label(_ws_obj_id);" / cymed

CREATE OR REPLACE FUNCTION qgep_od.on_reach_point_update()
  RETURNS trigger AS
$BODY$
DECLARE
  rp_obj_id text;
  _ws_obj_id text;
  ne_obj_ids text[];
  ne_obj_id text;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      IF (NEW.fk_wastewater_networkelement = OLD.fk_wastewater_networkelement) THEN
        RETURN NEW;
      END IF;
      rp_obj_id = OLD.obj_id;
      ne_obj_ids := ARRAY[OLD.fk_wastewater_networkelement, NEW.fk_wastewater_networkelement];
    WHEN TG_OP = 'INSERT' THEN
      rp_obj_id = NEW.obj_id;
      ne_obj_ids := ARRAY[NEW.fk_wastewater_networkelement];
    WHEN TG_OP = 'DELETE' THEN
      rp_obj_id = OLD.obj_id;
      ne_obj_ids := ARRAY[OLD.fk_wastewater_networkelement];
  END CASE;


  UPDATE qgep_od.reach
    SET progression_geometry = progression_geometry
    WHERE fk_reach_point_from = rp_obj_id OR fk_reach_point_to = rp_obj_id; --To retrigger the calculate_length trigger on reach update

  FOREACH ne_obj_id IN ARRAY ne_obj_ids
  LOOP
      SELECT ws.obj_id INTO _ws_obj_id
      FROM qgep_od.wastewater_structure ws
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      WHERE ne.obj_id = ne_obj_id;

      EXECUTE qgep_od.update_reach_point_label(_ws_obj_id);
      EXECUTE qgep_od.update_wastewater_structure_label(_ws_obj_id);
      EXECUTE qgep_od.update_depth(_ws_obj_id);
  END LOOP;

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;

--------------------------------------------------------
-- UPDATE wastewater structure label
-- Argument:
--  * obj_id of wastewater structure or NULL to update all
--------------------------------------------------------

------ 8.9.2023 use reach_point's _label /cymed
------ 14.9.2022 index labels by wastewater structure for VSA-DSS compliance /cymed
------ 14.9.2022 use idx only when more than one entry /cymed
------ 15.8.2018 uk adapted label display only for primary wastwater system
------ WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and CH_to.function_hierarchic in (5062,5064,5066,5068,5069,5070,5071,5072,5074)  ----label only reaches with function_hierarchic=pwwf.*
      				 


CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_structure_label(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
  DECLARE
  myrec record;
  BEGIN
  
  --Update wastewater structure label
  -- 2023_10_10: use labels table
 with labeled_ws as
(
	
    SELECT   ws_obj_id as obj_id,
          COALESCE(ws_identifier, '') as label,
          CASE WHEN count(co_level)<2 THEN array_to_string(array_agg(E'\nC' || '=' || co_level ORDER BY idx DESC), '', '') ELSE
		  array_to_string(array_agg(E'\nC' || idx || '=' || co_level ORDER BY idx ASC), '', '') END as cover_label,
          array_to_string(array_agg(E'\nB' || '=' || bottom_level), '', '') as bottom_label,
		  array_to_string(array_agg(E'\n'||rpi_label|| '=' || rpi_level ORDER BY rpi_label ASC), '', '')  as input_label,
		  array_to_string(array_agg(E'\n'||rpo_label|| '=' || rpo_level ORDER BY rpo_label ASC), '', '')  as output_label
		  FROM (
		  SELECT ws.obj_id AS ws_obj_id
		  , ws.identifier AS ws_identifier
		  , parts.co_level AS co_level
		  , parts.rpi_level AS rpi_level
		  , parts.rpo_level AS rpo_level
		  , parts.rpi_label AS rpi_label
		  , parts.rpo_label AS rpo_label
		  , parts.obj_id, idx
		  , parts.bottom_level AS bottom_level
    FROM qgep_od.wastewater_structure WS

    LEFT JOIN (
	  --cover	
      SELECT 
		coalesce(round(CO.level, 2)::text, '?') AS co_level
		, SP.fk_wastewater_structure ws
		, SP.obj_id
		, row_number() OVER(PARTITION BY SP.fk_wastewater_structure) AS idx
		, NULL::text AS bottom_level
		, NULL::text AS rpi_level
		, NULL::text  AS rpo_level
		, NULL::text as rpi_label
		, NULL::text  AS rpo_label
      FROM qgep_od.structure_part SP
      RIGHT JOIN qgep_od.cover CO ON CO.obj_id = SP.obj_id
      WHERE _all OR SP.fk_wastewater_structure = _obj_id
      -- Bottom
      UNION
      SELECT 
		NULL AS co_level
		, ws1.obj_id ws
		, NULL as obj_id
		, NULL as idx
		, coalesce(round(wn.bottom_level, 2)::text, '?') AS wn_bottom_level
		, NULL::text AS rpi_level
		, NULL::text  AS rpo_level
		, NULL::text as rpi_label
		, NULL::text  AS rpo_label
      FROM qgep_od.wastewater_structure ws1
      LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id = ws1.fk_main_wastewater_node
      WHERE _all OR ws1.obj_id = _obj_id
	  UNION
	  --input	
      SELECT 
		NULL AS co_level
		, NE.fk_wastewater_structure ws
		, RP.obj_id
		,NULL as idx
		, NULL::text AS bottom_level
		, coalesce(round(RP.level, 2)::text, '?') AS rpi_level
		, NULL::text AS rpo_level
		, lb._label as rpi_label
		,  NULL::text AS rpo_label
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
	  LEFT JOIN qgep_od.labels lb on RP.obj_id=lb.obj_id
      WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and left(lb._label,1)='I'
      -- output
      UNION
      SELECT  NULL AS co_level
		, NE.fk_wastewater_structure ws
		, RP.obj_id
		, NULL as idx
		, NULL::text AS bottom_level
		, NULL::text AS rpi_level
		, coalesce(round(RP.level, 2)::text, '?') AS rpo_level
		, NULL::text as rpi_label
		, lb._label AS rpo_label
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      LEFT JOIN qgep_od.labels lb on RP.obj_id=lb.obj_id
	  WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and left(lb._label,1)='O' 
	) parts ON parts.ws = ws.obj_id
    WHERE _all OR ws.obj_id =_obj_id
    ) all_parts
	GROUP BY ws_obj_id, COALESCE(ws_identifier, '')
)
  
INSERT INTO qgep_od.labels (obj_id,_label,_cover_label,_bottom_label,_input_label,_output_label) 
  SELECT  obj_id,label,cover_label,bottom_label,input_label,output_label
  FROM labeled_ws
  ON CONFLICT (obj_id) DO UPDATE
SET _label = EXCLUDED._label,
    _cover_label = EXCLUDED._cover_label,
    _bottom_label = EXCLUDED._bottom_label,
    _input_label = EXCLUDED._input_label,
    _output_label = EXCLUDED._output_label
;
END

$BODY$
LANGUAGE plpgsql
VOLATILE;

--------------------------------------------------
-- ON REACH CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.on_reach_change()
  RETURNS trigger AS
$BODY$
DECLARE
  rp_obj_ids TEXT[];
  _ws_obj_id TEXT;
  rps RECORD;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      rp_obj_ids = ARRAY[OLD.fk_reach_point_from, OLD.fk_reach_point_to];
    WHEN TG_OP = 'INSERT' THEN
      rp_obj_ids = ARRAY[NEW.fk_reach_point_from, NEW.fk_reach_point_to];
    WHEN TG_OP = 'DELETE' THEN
      rp_obj_ids = ARRAY[OLD.fk_reach_point_from, OLD.fk_reach_point_to];
  END CASE;

  FOR _ws_obj_id IN
    SELECT ws.obj_id
      FROM qgep_od.wastewater_structure ws
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep_od.reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      WHERE rp.obj_id = ANY ( rp_obj_ids )
  LOOP
   
    EXECUTE qgep_od.update_reach_point_label(_ws_obj_id); 
    EXECUTE qgep_od.update_wastewater_structure_label(_ws_obj_id);
    EXECUTE qgep_od.update_depth(_ws_obj_id);
  END LOOP;

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;


--------------------------------------------------
-- ON WASTEWATER STRUCTURE CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.on_wastewater_structure_update()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_obj_id TEXT;
BEGIN
  -- Prevent recursion
  IF COALESCE(OLD.identifier, '') = COALESCE(NEW.identifier, '') THEN
    RETURN NEW;
  END IF;
  _ws_obj_id = OLD.obj_id;
  EXECUTE qgep_od.update_wastewater_structure_label(_ws_obj_id);

  IF OLD.fk_main_cover != NEW.fk_main_cover THEN
    EXECUTE qgep_od.update_depth(_ws_obj_id);
  END IF;


  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;
--------------------------------------------------
-- ON WASTEWATER NODE CHANGE
--------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.on_wastewater_node_change()
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

  SELECT ne.fk_wastewater_structure INTO affected_sp
  FROM qgep_od.wastewater_networkelement ne
  WHERE obj_id = co_obj_id;

  EXECUTE qgep_od.update_depth(affected_sp.fk_wastewater_structure);
  EXECUTE qgep_od.update_reach_point_label(affected_sp.fk_wastewater_structure); 
  EXECUTE qgep_od.update_wastewater_structure_label(affected_sp.fk_wastewater_structure);

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
	-- Prevent recursion
      IF OLD.fk_wastewater_networkelement=NEW.fk_wastewater_networkelement THEN
      RETURN NEW;
      END IF;
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
  

DROP TRIGGER IF EXISTS on_wasterwaternode_change ON qgep_od.wastewater_node; -- name has been altered
DROP FUNCTION IF EXISTS qgep_od.on_wasterwaternode_change(); -- name has been altered

-----------------------------------------------------------------------
-- Drop Symbology Triggers
-- To temporarily disable these cache refreshes for batch jobs like migrations
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_sys.drop_symbology_triggers() RETURNS VOID AS $$
BEGIN
  DROP TRIGGER IF EXISTS on_reach_point_update ON qgep_od.reach_point;
  DROP TRIGGER IF EXISTS on_reach_2_change ON qgep_od.reach;
  DROP TRIGGER IF EXISTS on_reach_1_delete ON qgep_od.reach;
  DROP TRIGGER IF EXISTS on_wastewater_structure_update ON qgep_od.wastewater_structure;
  DROP TRIGGER IF EXISTS ws_label_update_by_wastewater_networkelement ON qgep_od.wastewater_networkelement;
  DROP TRIGGER IF EXISTS on_structure_part_change ON qgep_od.structure_part;
  DROP TRIGGER IF EXISTS on_cover_change ON qgep_od.cover;
  DROP TRIGGER IF EXISTS on_wastewater_node_change ON qgep_od.wastewater_node;
  DROP TRIGGER IF EXISTS ws_symbology_update_by_reach ON qgep_od.reach;
  DROP TRIGGER IF EXISTS ws_symbology_update_by_channel ON qgep_od.channel;
  DROP TRIGGER IF EXISTS ws_symbology_update_by_reach_point ON qgep_od.reach_point;
  DROP TRIGGER IF EXISTS calculate_reach_length ON qgep_od.reach;
  RETURN;
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- Create Symbology Triggers
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_sys.create_symbology_triggers() RETURNS VOID AS $$
BEGIN
  -- only update -> insert and delete are handled by reach trigger
  CREATE TRIGGER on_reach_point_update
  AFTER UPDATE
    ON qgep_od.reach_point
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_reach_point_update();

  CREATE TRIGGER on_reach_2_change
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_reach_change();

  CREATE TRIGGER on_reach_1_delete
  AFTER DELETE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_reach_delete();

  CREATE TRIGGER calculate_reach_length
  BEFORE INSERT OR UPDATE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.calculate_reach_length();

  CREATE TRIGGER ws_symbology_update_by_reach
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.ws_symbology_update_by_reach();

  CREATE TRIGGER on_wastewater_structure_update
  AFTER UPDATE
    ON qgep_od.wastewater_structure
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_wastewater_structure_update();

  CREATE TRIGGER ws_label_update_by_wastewater_networkelement
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.wastewater_networkelement
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_structure_part_change_networkelement();

  CREATE TRIGGER on_structure_part_change
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.structure_part
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_structure_part_change_networkelement();

  CREATE TRIGGER on_cover_change
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.cover
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_cover_change();

  CREATE TRIGGER on_wastewater_node_change
  AFTER INSERT OR UPDATE
    ON qgep_od.wastewater_node
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_wastewater_node_change();

  CREATE TRIGGER ws_symbology_update_by_channel
  AFTER INSERT OR UPDATE OR DELETE
  ON qgep_od.channel
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.ws_symbology_update_by_channel();

  -- only update -> insert and delete are handled by reach trigger
  CREATE TRIGGER ws_symbology_update_by_reach_point
  AFTER UPDATE
    ON qgep_od.reach_point
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.ws_symbology_update_by_reach_point();


  RETURN;
END;
$$ LANGUAGE plpgsql;

-- re-create triggers 
SELECT qgep_sys.drop_symbology_triggers();
SELECT qgep_sys.create_symbology_triggers();


--update all reach points and wastewater_structure labels
 SELECT qgep_od.update_reach_point_label(NULL,true);
 SELECT qgep_od.update_wastewater_structure_label(NULL,TRUE); 
