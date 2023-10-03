ALTER TABLE qgep_od.reach_point ADD COLUMN _label text;


COMMENT ON COLUMN qgep_od.wastewater_structure._usage_current IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';

COMMENT ON COLUMN qgep_od.wastewater_structure._function_hierarchic IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater
has to be updated by triggers';

COMMENT ON COLUMN qgep_od.manhole._orientation IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater';

COMMENT ON COLUMN qgep_od.wastewater_structure._label IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater';
;
COMMENT ON COLUMN qgep_od.wastewater_structure._cover_label IS 'stores the cover altitude to be used for labelling, not part of the VSA-DSS data model
added solely for TEKSI wastewater';

COMMENT ON COLUMN qgep_od.wastewater_structure._input_label IS 'stores the list of input altitudes to be used for labelling, not part of the VSA-DSS data model
added solely for TEKSI wastewater';

COMMENT ON COLUMN qgep_od.wastewater_structure._output_label IS 'stores the list of output altitudes to be used for labelling, not part of the VSA-DSS data model
added solely for TEKSI wastewater';

COMMENT ON COLUMN qgep_od.wastewater_structure._bottom_label IS 'stores the bottom altitude to be used for labelling, not part of the VSA-DSS data model
added solely for TEKSI wastewater';

COMMENT ON COLUMN qgep_od.reach_point._label IS 'not part of the VSA-DSS data model
added solely for TEKSI wastewater';

CREATE OR REPLACE FUNCTION qgep_od.update_reach_point_label(_obj_id text
	, _all boolean default false,
	_labeled_ws_status bigint[] DEFAULT '{8493,6530,6533}',
	_labeled_ch_func_hier bigint[] DEFAULT '{5062,5064,5066,5068,5089,5070,5071,5072,5074}')
  RETURNS VOID AS
 $BODY$
  DECLARE
  myrec record;
  BEGIN
  -- Updates the reach_point labels of the wastewater_structure 
  -- _obj_id: obj_id of the associatied wastewater structure
  -- _all: optional boolean to update all reach points
  -- _labeled_ws_status: codes of the ws_status to be labeled. Default: Array of operational.%%
  -- _labeled_ch_func_hier: codes of the ch_function_hierarchic to be labeled. Default: Array of pwwf.%%

-- to prevent a re-throw of on_reach_point_update
  IF _all THEN
    RAISE INFO 'Temporarily disabling symbology triggers';
    PERFORM qgep_sys.drop_symbology_triggers();
  END IF;
  
 --Update reach_point label
  UPDATE qgep_od.reach_point rp
  SET _label = rp_label.new_label
  FROM (
  with inp as( SELECT
    ne.fk_wastewater_structure
    , rp.obj_id
    , row_number() OVER(PARTITION BY NE.fk_wastewater_structure 
					ORDER BY ST_Azimuth(rp.situation_geometry,ST_PointN(re.progression_geometry,-2))/pi()*180 ASC) 
					as idx
    , count	(*) OVER(PARTITION BY NE.fk_wastewater_structure ) as max_idx				
      FROM qgep_od.reach_point rp
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      INNER JOIN qgep_od.reach re ON rp.obj_id = re.fk_reach_point_to
      LEFT JOIN qgep_od.wastewater_networkelement ne_re ON ne_re.obj_id = re.obj_id
      LEFT JOIN qgep_od.channel ch ON ne_re.fk_wastewater_structure = ch.obj_id
	  LEFT JOIN qgep_od.wastewater_structure ws ON ne_re.fk_wastewater_structure = ws.obj_id
	  WHERE ch.function_hierarchic= ANY(_labeled_ch_func_hier) 
			AND ws.status = ANY(_labeled_ws_status) 
		    AND ((_all AND ne.fk_wastewater_structure IS NOT NULL) 
			  OR ne.fk_wastewater_structure= _obj_id)), 
  outp as( SELECT
    ne.fk_wastewater_structure
    , rp.obj_id
    , row_number() OVER(PARTITION BY NE.fk_wastewater_structure 
					ORDER BY ST_Azimuth(rp.situation_geometry,ST_PointN(re.progression_geometry,-2))/pi()*180 ASC) 
					as idx
    , count	(*) OVER(PARTITION BY NE.fk_wastewater_structure ) as max_idx				
      FROM qgep_od.reach_point rp
      LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
      INNER JOIN qgep_od.reach re ON rp.obj_id = re.fk_reach_point_from
      LEFT JOIN qgep_od.wastewater_networkelement ne_re ON ne_re.obj_id = re.obj_id
      LEFT JOIN qgep_od.channel ch ON ne_re.fk_wastewater_structure = ch.obj_id
	  LEFT JOIN qgep_od.wastewater_structure ws ON ne_re.fk_wastewater_structure = ws.obj_id
	  WHERE ch.function_hierarchic= ANY(_labeled_ch_func_hier) 
			AND ws.status = ANY(_labeled_ws_status) 
		    AND ((_all AND ne.fk_wastewater_structure IS NOT NULL) 
			  OR ne.fk_wastewater_structure= _obj_id)) 
  SELECT 'I'||CASE WHEN max_idx=1 THEN '' ELSE idx::text END as new_label
  , obj_id
  FROM inp
 
  UNION
  SELECT 'O'||CASE WHEN max_idx=1 THEN '' ELSE idx::text END as new_label
  , obj_id
  FROM outp) rp_label
  WHERE rp_label.obj_id=rp.obj_id;

  -- See above
  IF _all THEN
    RAISE INFO 'Reenabling symbology triggers';
    PERFORM qgep_sys.create_symbology_triggers();
  END IF;
END;
$BODY$
LANGUAGE plpgsql
VOLATILE;

CREATE OR REPLACE FUNCTION qgep_od.on_reach_point_update()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
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
END; 
$BODY$;


CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_structure_label(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
  DECLARE
  myrec record;
  BEGIN
  
  --Update wastewater structure label
  -- 2023_05_12: use reach point labels
  UPDATE qgep_od.wastewater_structure ws
SET _label = label,
    _cover_label = cover_label,
    _bottom_label = bottom_label,
    _input_label = input_label,
    _output_label = output_label
    FROM(
SELECT   ws_obj_id,
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
		, round(wn.bottom_level, 2)::text AS wn_bottom_level
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
		, rp._label as rpi_label
		,  NULL::text AS rpo_label
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and left(RP._label,1)='I'
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
		, rp._label AS rpo_label
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and left(RP._label,1)='O'
	) AS parts ON parts.ws = ws.obj_id
    WHERE _all OR ws.obj_id =_obj_id
		  ) parts
		  GROUP BY ws_obj_id, COALESCE(ws_identifier, '')
) labeled_ws
WHERE ws.obj_id = labeled_ws.ws_obj_id;

END

$BODY$
LANGUAGE plpgsql
VOLATILE;

SELECT qgep_od.update_reach_point_label(NULL,true);
