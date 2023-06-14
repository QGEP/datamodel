CREATE OR REPLACE VIEW qgep_sigip.vw_files AS

  SELECT f.object AS obj_id,
    string_agg(dm.path || f.path_relative, ','::text) AS fichiers

  FROM qgep_od.file f
    LEFT JOIN qgep_od.data_media dm ON dm.obj_id::text = f.fk_data_media::text

  WHERE f.object IS NOT NULL

  GROUP BY f.object;

