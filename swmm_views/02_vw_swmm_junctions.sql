--------
-- View for the swmm module class junctions
--------
CREATE OR REPLACE VIEW qgep_swmm.vw_junctions AS


WITH outs AS (
  SELECT 
    wn_1.obj_id, 
    count(re.obj_id) AS amount 
  FROM 
    qgep_od.wastewater_node wn_1 
    LEFT JOIN qgep_od.reach_point rp ON rp.fk_wastewater_networkelement :: text = wn_1.obj_id :: text 
    LEFT JOIN qgep_od.reach re ON re.fk_reach_point_from :: text = rp.obj_id :: text 
    LEFT JOIN qgep_od.wastewater_networkelement ne_1 ON ne_1.obj_id :: text = re.obj_id :: text 
    LEFT JOIN qgep_od.wastewater_structure ws_1 ON ws_1.obj_id :: text = ne_1.fk_wastewater_structure :: text 
    LEFT JOIN qgep_vl.wastewater_structure_status ws_st_1 ON ws_1.status = ws_st_1.code 
	LEFT JOIN qgep_od.channel ch on ch.obj_id::text = ws_1.obj_id::text
	LEFT JOIN qgep_vl.channel_function_hydraulic ch_fhyd on ch_fhyd.code = ch.function_hydraulic
  WHERE 
    (
      ws_st_1.vsacode = ANY (
        ARRAY[6530, 6533, 8493, 6529, 6526, 
        7959]
      )
    OR ws_st_1.vsacode IS NULL )
	AND ch_fhyd.vsacode!=23 -- pump pipes do not need a divider beforehand
  GROUP BY 
    wn_1.obj_id
) 
SELECT 
  wn.obj_id :: character varying AS name, 
  COALESCE(wn.bottom_level, 0 :: numeric) AS invertelev, 
  co.level - wn.bottom_level AS maxdepth, 
  NULL :: double precision AS initdepth, 
  NULL :: double precision AS surchargedepth, 
  NULL :: double precision AS pondedarea, 
  COALESCE(
    ws.identifier :: text, ne.identifier :: text
  ) AS description, 
  COALESCE(
    'manhole,' :: text || mf.value_en :: text, 
    'special_structure,' :: text || ssf.value_en :: text, 
    'junction_without_structure' :: text
  ) AS tag, 
  wn.situation_geometry AS geom, 
  CASE WHEN ws_st.vsacode = ANY (ARRAY[7959, 6529, 6526]) THEN 'planned' :: text ELSE 'current' :: text END AS state, 
  CASE WHEN ch_fh.vsacode = ANY (
    ARRAY[5062, 5064, 5066, 5068, 5069, 
    5070, 5071, 5072, 5074]
  ) THEN 'primary' :: text ELSE 'secondary' :: text END AS hierarchy, 
  wn.obj_id 
FROM 
  qgep_od.wastewater_node wn 
  LEFT JOIN qgep_od.wastewater_networkelement ne ON wn.obj_id :: text = ne.obj_id :: text 
  LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure :: text = ws.obj_id :: text 
  LEFT JOIN qgep_od.cover co ON ws.fk_main_cover :: text = co.obj_id :: text 
  LEFT JOIN qgep_od.manhole ma ON ma.obj_id :: text = ws.obj_id :: text 
  LEFT JOIN qgep_vl.manhole_function mf ON ma.function = mf.code 
  LEFT JOIN qgep_od.special_structure ss ON ss.obj_id :: text = ws.obj_id :: text 
  LEFT JOIN qgep_vl.special_structure_function ssf ON ss.function = ssf.code 
  LEFT JOIN qgep_od.infiltration_installation ii ON ii.obj_id :: text = ws.obj_id :: text 
  LEFT JOIN qgep_od.discharge_point dp ON dp.obj_id :: text = ws.obj_id :: text 
  LEFT JOIN (
    SELECT 
      wn_1.obj_id 
    FROM 
      qgep_od.prank_weir pw 
      LEFT JOIN qgep_od.overflow ov ON pw.obj_id :: text = ov.obj_id :: text 
      LEFT JOIN qgep_od.wastewater_node wn_1 ON wn_1.obj_id :: text = ov.fk_wastewater_node :: text 
      LEFT JOIN qgep_od.overflow_char oc ON ov.fk_overflow_characteristic :: text = oc.obj_id :: text 
      LEFT JOIN qgep_vl.overflow_char_overflow_characteristic_digital vl_oc_dig ON oc.overflow_characteristic_digital = vl_oc_dig.code 
      LEFT JOIN qgep_vl.overflow_char_kind_overflow_characteristic vl_oc_ki ON oc.kind_overflow_characteristic = vl_oc_ki.code 
    WHERE 
      vl_oc_dig.vsacode = 6223 --see storage
      AND vl_oc_ki.vsacode = 6220 --see storage
  ) stor ON stor.obj_id :: text = wn.obj_id :: text 
  LEFT JOIN outs ON outs.obj_id :: text = wn.obj_id :: text 
  LEFT JOIN qgep_vl.wastewater_structure_status ws_st ON ws_st.code = wn._status 
  LEFT JOIN qgep_vl.channel_function_hierarchic ch_fh ON ch_fh.code = wn._function_hierarchic 
WHERE 
  (
    ws_st.vsacode = ANY (
      ARRAY[6530, 6533, 8493, 6529, 6526, 
      7959]
    )
  ) 
  AND (
    ssf.vsacode IS NULL 
    OR (
      ssf.vsacode <> ANY (
        ARRAY[6397, --"pit_without_drain"
-- 245, --"drop_structure"
6398, --"hydrolizing_tank"
-- 5371, --"other"
-- 386, --"venting"
-- 3234, --"inverse_syphon_chamber"
-- 5091, --"syphon_head"
-- 6399, --"septic_tank_two_chambers"
3348, --"terrain_depression"
336, --"bolders_bedload_catchement_dam"
-- 5494, --"cesspit"
6478, --"septic_tank"
-- 2998, --"manhole"
-- 2768, --"oil_separator"
246, --"pump_station"
3673, --"stormwater_tank_with_overflow"
3674, --"stormwater_tank_retaining_first_flush"
5574, --"stormwater_retaining_channel"
3675, --"stormwater_sedimentation_tank"
3676, --"stormwater_retention_tank"
-- 5575, --"stormwater_retention_channel"
-- 5576, --"stormwater_storage_channel"
3677 --"stormwater_composite_tank"
-- 5372 --"stormwater_overflow"
-- 5373, --"floating_material_separator"
-- 383	, --"side_access"
-- 227, --"jetting_manhole"
-- 4799, --"separating_structure"
-- 3008, --"unknown"
-- 2745, --"vortex_manhole"
] --see storage
      )
    )
  ) 
  AND stor.obj_id IS NULL 
  AND ii.obj_id IS NULL 
  AND dp.obj_id IS NULL 
  AND (outs.amount < 2 OR outs.amount IS NULL);
