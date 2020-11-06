CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_structure_symbology(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
BEGIN
UPDATE qgep_od.wastewater_structure ws
SET
  _function_hierarchic = function_hierarchic,
  _usage_current = usage_current
FROM(
  SELECT DISTINCT ON (ws.obj_id) ws.obj_id AS ws_obj_id,
      COALESCE(first_value(CH_from.function_hierarchic) OVER w, first_value(CH_to.function_hierarchic) OVER w) AS function_hierarchic,
      COALESCE(first_value(CH_from.usage_current) OVER w, first_value(CH_to.usage_current) OVER w) AS usage_current,
      rank() OVER w AS hierarchy_rank
    FROM
      qgep_od.wastewater_structure ws
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.fk_wastewater_structure = ws.obj_id
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
    WHERE _all OR ws.obj_id = _obj_id
      WINDOW w AS ( PARTITION BY ws.obj_id ORDER BY vl_fct_hier_from.order_fct_hierarchic ASC NULLS LAST, vl_fct_hier_to.order_fct_hierarchic ASC NULLS LAST,
                                vl_usg_curr_from.order_usage_current ASC NULLS LAST, vl_usg_curr_to.order_usage_current ASC NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
) symbology_ws
WHERE symbology_ws.ws_obj_id = ws.obj_id;
END
$BODY$
LANGUAGE plpgsql
VOLATILE;
