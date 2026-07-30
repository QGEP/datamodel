CREATE OR REPLACE VIEW qgep_sigip.vw_export_file AS
  SELECT obj_id,
    object as fk_obj_id,
    _url as url,
    kind.value_fr as type
  FROM qgep_od.vw_file file
  LEFT JOIN qgep_vl.file_kind kind ON file.kind = kind.code
  WHERE object is NOT NULL;
