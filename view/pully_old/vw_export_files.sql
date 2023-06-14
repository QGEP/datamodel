CREATE OR REPLACE VIEW qgep_sigip.vw_export_files AS
  SELECT object as obj_id,
    string_agg(_url,',') as fichiers
  FROM qgep_od.vw_file
  WHERE object is NOT NULL
  GROUP BY object;
