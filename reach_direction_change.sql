CREATE OR REPLACE FUNCTION qgep_od.reach_direction_change(reach_obj_ids text[])RETURNS void AS $BODY$

BEGIN 
 
UPDATE qgep_od.reach 
  SET
    progression_geometry = (ST_ForceCurve(ST_Reverse(ST_CurveToLine(progression_geometry)))),
    fk_reach_point_from = fk_reach_point_to,
    fk_reach_point_to = fk_reach_point_from
  WHERE obj_id = ANY(reach_obj_ids);
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
