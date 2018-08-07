CREATE OR REPLACE FUNCTION qgep_od.reach_direction_change(reach_obj_ids text[])RETURNS void AS $BODY$

BEGIN 
 
UPDATE qgep_od.vw_qgep_reach 

SET progression_geometry = (ST_ForceCurve(ST_Reverse(ST_CurveToLine(progression_geometry))))
WHERE obj_id = ANY(reach_obj_ids);
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
