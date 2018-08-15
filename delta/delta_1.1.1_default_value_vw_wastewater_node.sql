ALTER TABLE qgep_od.vw_wastewater_node ALTER COLUMN obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od'::text, 'wastewater_node'::text);

