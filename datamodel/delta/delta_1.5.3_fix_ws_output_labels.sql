CREATE OR REPLACE FUNCTION qgep_od.update_wastewater_structure_label(_obj_id text, _all boolean default false)
  RETURNS VOID AS
  $BODY$
  DECLARE
  myrec record;

BEGIN
UPDATE qgep_od.wastewater_structure ws
SET _label = label,
    _cover_label = cover_label,
    _bottom_label = bottom_label,
    _input_label = input_label,
    _output_label = output_label
FROM (
  SELECT  ws_obj_id,
          COALESCE(ws_identifier, '') as label,
          array_to_string(array_agg(E'\nC' || '=' || co_level ORDER BY co_level DESC), '', '') as cover_label,
          array_to_string(array_agg(E'\nB' || '=' || bottom_level), '', '') as bottom_label,
          array_to_string(array_agg(E'\nI' || idx || '=' || rpi_level ORDER BY idx), '', '') as input_label,
          array_to_string(array_agg(E'\nO' || idx || '=' || rpo_level ORDER BY idx), '', '') as output_label
  FROM (
    SELECT ws.obj_id AS ws_obj_id, ws.identifier AS ws_identifier, parts.co_level AS co_level, parts.rpi_level AS rpi_level, parts.rpo_level AS rpo_level, parts.obj_id, idx, bottom_level AS bottom_level
    FROM qgep_od.wastewater_structure WS

    LEFT JOIN (
      -- Cover
      SELECT coalesce(round(CO.level, 2)::text, '?') AS co_level, NULL::text AS rpi_level, NULL::text AS rpo_level, SP.fk_wastewater_structure ws, SP.obj_id, row_number() OVER(PARTITION BY SP.fk_wastewater_structure) AS idx, NULL::text AS bottom_level
      FROM qgep_od.structure_part SP
      RIGHT JOIN qgep_od.cover CO ON CO.obj_id = SP.obj_id
      WHERE _all OR SP.fk_wastewater_structure = _obj_id
      -- Inputs
      UNION
      SELECT NULL AS co_level, coalesce(round(RP.level, 2)::text, '?') AS rpi_level, NULL::text AS rpo_level, NE.fk_wastewater_structure ws, RP.obj_id, row_number() OVER(PARTITION BY RP.fk_wastewater_networkelement ORDER BY ST_Azimuth(RP.situation_geometry,ST_PointN(RE_to.progression_geometry,-2))/pi()*180 ASC), NULL::text AS bottom_level
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      INNER JOIN qgep_od.reach RE_to ON RP.obj_id = RE_to.fk_reach_point_to
      LEFT JOIN qgep_od.wastewater_networkelement NE_to ON NE_to.obj_id = RE_to.obj_id
      LEFT JOIN qgep_od.channel CH_to ON NE_to.fk_wastewater_structure = CH_to.obj_id
      WHERE (_all OR NE.fk_wastewater_structure = _obj_id) and CH_to.function_hierarchic in (5062,5064,5066,5068,5069,5070,5071,5072,5074)  ----label only reaches with function_hierarchic=pwwf.*
      -- Outputs
      UNION
      SELECT NULL AS co_level, NULL::text AS rpi_level, coalesce(round(RP.level, 2)::text, '?') AS rpo_level, NE.fk_wastewater_structure ws, RP.obj_id, row_number() OVER(PARTITION BY RP.fk_wastewater_networkelement ORDER BY ST_Azimuth(RP.situation_geometry,ST_PointN(RE_from.progression_geometry,2))/pi()*180 ASC), NULL::text AS bottom_level
      FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      INNER JOIN qgep_od.reach RE_from ON RP.obj_id = RE_from.fk_reach_point_from
      WHERE CASE WHEN _obj_id IS NULL THEN TRUE ELSE NE.fk_wastewater_structure = _obj_id END
      -- Bottom
      UNION
      SELECT NULL AS co_level, NULL::text AS rpi_level, NULL::text AS rpo_level, ws1.obj_id ws, NULL, NULL, round(wn.bottom_level, 2)::text AS wn_bottom_level
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