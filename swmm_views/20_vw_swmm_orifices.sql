CREATE OR REPLACE VIEW qgep_swmm.vw_orifices AS

SELECT
NULL::text as Name,
wn.obj_id as FromNode,
NULL::text as ToNode,
'SIDE'::text as Type,
'CIRCULAR'::text as Shape,
0::text as Offset,
0.65::text as Qcoeff,
'NO'::text as Gated,
0 ::text as CloseTime,
  CASE WHEN ws_st.vsacode = ANY (ARRAY[7959, 6529, 6526]) THEN 'planned' :: text ELSE 'current' :: text END AS state, 
  CASE WHEN ch_fh.vsacode = ANY (
    ARRAY[5062, 5064, 5066, 5068, 5069, 
    5070, 5071, 5072, 5074]
  ) THEN 'primary' :: text ELSE 'secondary' :: text END AS hierarchy, 
NULL::text as obj_id
FROM qgep_od.throttle_shut_off_unit tsu
LEFT JOIN qgep_vl.throttle_shut_off_unit_kind tsu_ki ON tsu_ki.code = tsu.kind
LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id = tsu.fk_wastewater_node
LEFT JOIN qgep_vl.wastewater_structure_status ws_st ON ws_st.code = wn._status 
LEFT JOIN qgep_vl.channel_function_hierarchic ch_fh ON ch_fh.code = wn._function_hierarchic 
WHERE tsu_ki.vsacode = ANY(ARRAY[13,134,135,252,2746]);