CREATE OR REPLACE VIEW qgep_sigip.vw_file AS

  SELECT f.obj_id,
    f.object AS fk_obj_id,
    dm.path || f.path_relative AS url,
    kind.value_fr AS type
  FROM qgep_od.file f
    LEFT JOIN qgep_od.data_media dm ON dm.obj_id::text = f.fk_data_media::text
    LEFT JOIN qgep_vl.file_kind kind ON f.kind = kind.code

  WHERE f.object IS NOT NULL;

