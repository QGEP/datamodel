
-- Add Wastewater node level to ws label in french

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
       COALESCE(ws_identifier, '') || E'\n' || 
        array_to_string(
         array_append(array_agg('C' || '=' || co_level::text ORDER BY co_level DESC), ''),
         E'\n'
        ) ||
       array_to_string(
         array_append(array_agg(lbl_type || idx || '=' || rp_level ORDER BY lbl_type, idx), '')
           , E'\n'
         ) ||
	   array_to_string(
         array_append(array_agg('B' || '=' || bottom_level), '')
           , E'\n'
         )
	AS label
  FROM (
    SELECT ws.obj_id AS ws_obj_id, ws.identifier AS ws_identifier, parts.lbl_type, round(parts.co_level, 2) AS co_level, round(parts.rp_level, 2) AS rp_level, parts.obj_id, idx, round(bottom_level, 2) AS bottom_level
    FROM qgep_od.wastewater_structure WS

    LEFT JOIN (
      SELECT 'C' as lbl_type, CO.level AS co_level, NULL AS rp_level, SP.fk_wastewater_structure ws, SP.obj_id, row_number() OVER(PARTITION BY SP.fk_wastewater_structure) AS idx, NULL::numeric(5,3) AS bottom_level
      FROM qgep_od.structure_part SP
      RIGHT JOIN qgep_od.cover CO ON CO.obj_id = SP.obj_id
      WHERE _all OR SP.fk_wastewater_structure = _obj_id
      UNION
      SELECT 'I' as lbl_type, NULL, RP.level AS rp_level, NE.fk_wastewater_structure ws, RP.obj_id, row_number() OVER(PARTITION BY RP.fk_wastewater_networkelement ORDER BY ST_Azimuth(RP.situation_geometry,ST_LineInterpolatePoint(ST_CurveToLine(RE_to.progression_geometry),0.99))/pi()*180 ASC), NULL::numeric(5,3) AS bottom_level
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      INNER JOIN qgep_od.reach RE_to ON RP.obj_id = RE_to.fk_reach_point_to
      LEFT JOIN qgep_od.wastewater_networkelement NE_to ON NE_to.obj_id = RE_to.obj_id
      LEFT JOIN qgep_od.channel CH_to ON NE_to.fk_wastewater_structure = CH_to.obj_id
      WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and CH_to.function_hierarchic in (5062,5064,5066,5068,5069,5070,5071,5072,5074)  ----label only reaches with function_hierarchic=pwwf.*
      UNION
      SELECT 'O' as lbl_type, NULL, RP.level AS rp_level, NE.fk_wastewater_structure ws, RP.obj_id, row_number() OVER(PARTITION BY RP.fk_wastewater_networkelement ORDER BY ST_Azimuth(RP.situation_geometry,ST_LineInterpolatePoint(ST_CurveToLine(RE_from.progression_geometry),0.99))/pi()*180 ASC), NULL::numeric(5,3) AS bottom_level
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      INNER JOIN qgep_od.reach RE_from ON RP.obj_id = RE_from.fk_reach_point_from
      WHERE CASE WHEN _obj_id IS NULL THEN TRUE ELSE NE.fk_wastewater_structure = _obj_id END
      UNION SELECT 'B' as lbl_type, NULL, NULL AS rp_level, ws1.obj_id ws, NULL, NULL, wn.bottom_level AS wn_bottom_level
      FROM qgep_od.wastewater_structure ws1
      LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id = ws1.fk_main_wastewater_node
      WHERE _all OR ws1.obj_id = _obj_id
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

-- Add wasterwater node update on trigger

CREATE OR REPLACE FUNCTION qgep_od.on_wasterwaternode_change()
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
  EXECUTE qgep_od.update_wastewater_structure_label(affected_sp.fk_wastewater_structure);

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql 
VOLATILE;

