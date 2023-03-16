
--- Changed order of identification label: new identifier, cover level, input / output instead of cover level first
--- uk / sb

CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_structure_label(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
  DECLARE
  myrec record;

BEGIN
UPDATE qgep_od.wastewater_structure ws
SET _label = label
FROM (
  SELECT ws_obj_id,
       COALESCE(ws_identifier, '') ||
       E'\n' ||
        array_to_string(
         array_agg( 'C' || '=' || co_level::text ORDER BY co_level DESC),
         E'\n'
        )||
       E'\n' ||
       array_to_string(
         array_agg(lbl_type || idx || '=' || rp_level ORDER BY lbl_type, idx)
           , E'\n'
         ) AS label
  FROM (
    SELECT ws.obj_id AS ws_obj_id, ws.identifier AS ws_identifier, parts.lbl_type, parts.co_level, parts.rp_level, parts.obj_id, idx
    FROM qgep_od.wastewater_structure WS

    LEFT JOIN (
      SELECT 'C' as lbl_type, CO.level AS co_level, NULL AS rp_level, SP.fk_wastewater_structure ws, SP.obj_id, row_number() OVER(PARTITION BY SP.fk_wastewater_structure) AS idx
      FROM qgep_od.structure_part SP
      RIGHT JOIN qgep_od.cover CO ON CO.obj_id = SP.obj_id
      WHERE _all OR SP.fk_wastewater_structure = _obj_id
      UNION
      SELECT 'I' as lbl_type, NULL, RP.level AS rp_level, NE.fk_wastewater_structure ws, RP.obj_id, row_number() OVER(PARTITION BY RP.fk_wastewater_networkelement ORDER BY ST_Azimuth(RP.situation_geometry,ST_LineInterpolatePoint(ST_CurveToLine(RE_to.progression_geometry),0.99))/pi()*180 ASC)
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      INNER JOIN qgep_od.reach RE_to ON RP.obj_id = RE_to.fk_reach_point_to
      LEFT JOIN qgep_od.wastewater_networkelement NE_to ON NE_to.obj_id = RE_to.obj_id
      LEFT JOIN qgep_od.channel CH_to ON NE_to.fk_wastewater_structure = CH_to.obj_id
      WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and CH_to.function_hierarchic in (5062,5064,5066,5068,5069,5070,5071,5072,5074)  ----label only reaches with function_hierarchic=pwwf.*
      UNION
      SELECT 'O' as lbl_type, NULL, RP.level AS rp_level, NE.fk_wastewater_structure ws, RP.obj_id, row_number() OVER(PARTITION BY RP.fk_wastewater_networkelement ORDER BY ST_Azimuth(RP.situation_geometry,ST_LineInterpolatePoint(ST_CurveToLine(RE_from.progression_geometry),0.99))/pi()*180 ASC)
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      INNER JOIN qgep_od.reach RE_from ON RP.obj_id = RE_from.fk_reach_point_from
      WHERE CASE WHEN _obj_id IS NULL THEN TRUE ELSE NE.fk_wastewater_structure = _obj_id END
    ) AS parts ON ws = ws.obj_id
    WHERE _all OR ws.obj_id = _obj_id
  ) parts
  GROUP BY ws_obj_id, COALESCE(ws_identifier, '')
) labeled_ws
WHERE ws.obj_id = labeled_ws.ws_obj_id;

END

$BODY$
LANGUAGE plpgsql
VOLATILE;

--- the following code is updating all existinng labels

SELECT qgep_od.update_wastewater_structure_label(NULL, true);

