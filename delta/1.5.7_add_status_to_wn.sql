-- adds the wastewater structure's status to the wastewater node

---- ALTER qgep_od.wastewater_node----
ALTER TABLE qgep_od.wastewater_node ADD COLUMN _status integer;
COMMENT ON COLUMN qgep_od.wastewater_node._status IS 'not part of the VSA-DSS data model
added solely for QGEP
has to be updated by triggers';

----UPDATE vw_wastewater_node----
DROP VIEW qgep_od.vw_wastewater_node;

CREATE OR REPLACE VIEW qgep_od.vw_wastewater_node
 AS
 SELECT wastewater_node.obj_id,
    wastewater_node._function_hierarchic,
    wastewater_node._usage_current,
    wastewater_node._status,
    wastewater_node.backflow_level,
    wastewater_node.bottom_level,
    wastewater_node.fk_hydr_geometry,
    wastewater_node.situation_geometry,
    wastewater_networkelement.fk_dataowner,
    wastewater_networkelement.fk_provider,
    wastewater_networkelement.fk_wastewater_structure,
    wastewater_networkelement.identifier,
    wastewater_networkelement.last_modification,
    wastewater_networkelement.remark
   FROM qgep_od.wastewater_node
     LEFT JOIN qgep_od.wastewater_networkelement ON wastewater_networkelement.obj_id::text = wastewater_node.obj_id::text;

ALTER TABLE qgep_od.vw_wastewater_node
    OWNER TO postgres;

CREATE TRIGGER tr_vw_wastewater_node_on_delete
    INSTEAD OF DELETE
    ON qgep_od.vw_wastewater_node
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_wastewater_node_delete();


CREATE TRIGGER tr_vw_wastewater_node_on_insert
    INSTEAD OF INSERT
    ON qgep_od.vw_wastewater_node
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_wastewater_node_insert();


CREATE TRIGGER tr_vw_wastewater_node_on_update
    INSTEAD OF UPDATE 
    ON qgep_od.vw_wastewater_node
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_wastewater_node_update();

ALTER VIEW qgep_od.vw_wastewater_node
    ALTER COLUMN obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od'::text, 'wastewater_node'::text);


----UPDATE SYMBOLOGY----

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
  _usage_current = usage_current,
  _status = status
FROM(
  SELECT DISTINCT ON (ne.obj_id) ne.obj_id AS ne_obj_id,
      COALESCE(first_value(CH_from.function_hierarchic) OVER w, first_value(CH_to.function_hierarchic) OVER w) AS function_hierarchic,
      COALESCE(first_value(CH_from.usage_current) OVER w, first_value(CH_to.usage_current) OVER w) AS usage_current,
      COALESCE(first_value(ws_from.status) OVER w, first_value(ws_to.status) OVER w) AS status,
      rank() OVER w AS hierarchy_rank
    FROM
      qgep_od.wastewater_networkelement ne
      LEFT JOIN qgep_od.reach_point rp ON ne.obj_id = rp.fk_wastewater_networkelement
      LEFT JOIN qgep_od.reach                       re_from           	ON re_from.fk_reach_point_from = rp.obj_id
      LEFT JOIN qgep_od.wastewater_networkelement   ne_from           	ON ne_from.obj_id = re_from.obj_id
      LEFT JOIN qgep_od.channel                     CH_from           	ON CH_from.obj_id = ne_from.fk_wastewater_structure
      LEFT JOIN qgep_od.wastewater_structure        ws_from           	ON ws_from.obj_id = ne_from.fk_wastewater_structure
      LEFT JOIN qgep_vl.channel_function_hierarchic vl_fct_hier_from	ON CH_from.function_hierarchic = vl_fct_hier_from.code
      LEFT JOIN qgep_vl.channel_usage_current       vl_usg_curr_from	ON CH_from.usage_current = vl_usg_curr_from.code

      LEFT JOIN qgep_od.reach                       re_to          	ON re_to.fk_reach_point_to = rp.obj_id
      LEFT JOIN qgep_od.wastewater_networkelement   ne_to          	ON ne_to.obj_id = re_to.obj_id
      LEFT JOIN qgep_od.channel                     CH_to          	ON CH_to.obj_id = ne_to.fk_wastewater_structure
      LEFT JOIN qgep_od.wastewater_structure        ws_to           	ON ws_to.obj_id = ne_to.fk_wastewater_structure
      LEFT JOIN qgep_vl.channel_function_hierarchic vl_fct_hier_to 	ON CH_to.function_hierarchic = vl_fct_hier_to.code
      LEFT JOIN qgep_vl.channel_usage_current       vl_usg_curr_to 	ON CH_to.usage_current = vl_usg_curr_to.code
    WHERE ne.obj_id = _obj_id
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
