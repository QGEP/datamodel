
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
-- UPDATE wastewater structure symbology
-- Argument:
--  * obj_id of wastewater networkelement or NULL to update all
--------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_node_symbology(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
BEGIN
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
END
$BODY$
LANGUAGE plpgsql
VOLATILE;


  -------------------- SYMBOLOGY UPDATE ON CHANNEL TABLE CHANGES ----------------------

CREATE OR REPLACE FUNCTION qgep_od.ws_symbology_update_by_channel()
  RETURNS trigger AS
$BODY$
DECLARE
  _ws_id TEXT;
  _ne_id TEXT;
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
  
  -- TODO : INTO will only store one row's result in the variable, while the query has two results, is that correct ? Consider using INTO STRICT.
  SELECT ws.obj_id, ne.obj_id INTO _ws_id, _ne_id
    FROM qgep_od.wastewater_networkelement ch_ne
    LEFT JOIN qgep_od.reach re ON ch_ne.obj_id = re.obj_id
    LEFT JOIN qgep_od.reach_point rp ON (re.fk_reach_point_from = rp.obj_id OR re.fk_reach_point_to = rp.obj_id )
    LEFT JOIN qgep_od.wastewater_networkelement ne ON rp.fk_wastewater_networkelement = ne.obj_id
    LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure = ws.obj_id
    WHERE ch_ne.fk_wastewater_structure = ch_obj_id;

  EXECUTE qgep_od.update_wastewater_structure_symbology(_ws_id);
  EXECUTE qgep_od.update_wastewater_node_symbology(_ne_id);
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

