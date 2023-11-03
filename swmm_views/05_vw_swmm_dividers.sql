--------
-- View for the swmm module class dividers
-- Question attribute Diverted Link: Name of link which receives the diverted flow. overflow > fk_overflow_to
CREATE OR REPLACE VIEW qgep_swmm.vw_dividers
 AS
 WITH outs AS (
         SELECT wn_1.obj_id,
            count(re.obj_id) AS amount
           FROM qgep_od.wastewater_node wn_1
             LEFT JOIN qgep_od.reach_point rp ON rp.fk_wastewater_networkelement::text = wn_1.obj_id::text
             LEFT JOIN qgep_od.reach re ON re.fk_reach_point_from::text = rp.obj_id::text
             LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id::text = re.obj_id::text
             LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id::text = ne.fk_wastewater_structure::text
	 		 LEFT JOIN qgep_od.channel ch ON ch.obj_id::text = ws.obj_id::text
             LEFT JOIN qgep_vl.wastewater_structure_status ws_st_1 ON ws.status = ws_st_1.code
	         LEFT JOIN qgep_vl.channel_function_hydraulic ch_fhyd ON ch.function_hydraulic = ch_fhyd.code
          WHERE (ws_st_1.vsacode = ANY (ARRAY[6530, 6533, 8493, 6529, 6526, 7959]) 
				 OR ws_st_1.vsacode IS NULL) 
	 AND ch_fhyd.vsacode!=23 -- pump pipes do not need a divider beforehand
          GROUP BY wn_1.obj_id
        )
 SELECT wn.obj_id AS name,
    COALESCE(wn.bottom_level, 0::numeric) AS elevation,
    '???'::text AS diverted_link,  -- tbd: once the _label for reach point is introduced, the order can be used to define the diverted link
    'CUTOFF'::text AS type,
    0 AS cutoffflow,
    0 AS maxdepth,
    0 AS initialdepth,
    0 AS surchargedepth,
    0 AS pondedarea,
    wn.situation_geometry AS geom,
        CASE
            WHEN ws_st.vsacode = ANY (ARRAY[7959, 6529, 6526]) THEN 'planned'::text
            ELSE 'current'::text
        END AS state,
        CASE
            WHEN cfhi.vsacode = ANY (ARRAY[5062, 5064, 5066, 5068, 5069, 5070, 5071, 5072, 5074]) THEN 'primary'::text
            ELSE 'secondary'::text
        END AS hierarchy,
    ws.obj_id
   FROM qgep_od.wastewater_node wn
     LEFT JOIN outs ON outs.obj_id::text = wn.obj_id::text
     LEFT JOIN qgep_vl.wastewater_structure_status ws_st ON wn._status = ws_st.code
     LEFT JOIN qgep_vl.channel_function_hierarchic cfhi ON cfhi.code = wn._function_hierarchic
  WHERE outs.amount = 2 AND (ws_st.vsacode = ANY (ARRAY[6530, 6533, 8493, 6529, 6526, 7959]));
