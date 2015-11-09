SELECT qgep.fn_inherited_table_view(
        '{
                "overflow": {
                        "table_name":"qgep.od_overflow",
                        "pkey": "obj_id",
                        "pkey_value":" qgep.generate_oid(''od_reach_point'')",
                        "destination_schema": "qgep",
                        "inherited_by": {
                                "leapingweir": {
                                        "table_name":"qgep.od_leapingweir",
                                        "pkey": "obj_id"
                                },
                                "prank_weir": {
                                        "table_name":"qgep.od_prank_weir",
                                        "pkey": "obj_id"
                                },
                                "pump": {
                                        "table_name":"qgep.od_pump",
                                        "pkey": "obj_id"
                                }
                        },
                        "merge_view": {
                                "view_name":"vw_qgep_overflow",
                                "additional_columns": {
                                        "geometry": "ST_MakeLine(n1.situation_geometry,n2.situation_geometry)::geometry(LineString,21781)"
                                },
                                "additional_join" : "LEFT JOIN qgep.od_wastewater_node n1 ON overflow.fk_wastewater_node = n1.obj_id LEFT JOIN qgep.od_wastewater_node n2 ON overflow.fk_overflow_to = n2.obj_id"
                        }
                }
        }'::json
);
