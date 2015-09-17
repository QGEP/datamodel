SELECT qgep.fn_inherited_table_view(
  '{
    "shortname": "overflow",
    "table_name":"qgep.od_overflow",
    "pkey": "obj_id",
    "pkey_nextval":" qgep.generate_oid(''od_overflow'')"
  }'::json,
  ARRAY[
    '{
      "shortname": "leapingweir",
      "table_name":"qgep.od_leapingweir",
      "pkey": "obj_id"
    }',
    '{
      "shortname": "prank_weir",
      "table_name":"qgep.od_prank_weir",
      "pkey": "obj_id"
    }',
    '{
      "shortname": "pump",
      "table_name":"qgep.od_pump",
      "pkey": "obj_id"
    }'
  ]::json[],
  'qgep'::text
);

