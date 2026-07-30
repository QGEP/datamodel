CREATE OR REPLACE VIEW qgep_sigip.vw_export_cr_photo_max AS
  SELECT ws.obj_id,
  regexp_replace(max(file._url), '\/'::text, '\'::text, 'g'::text) AS url,
  count(*) AS nbre_photos
  FROM qgep_od.vw_qgep_wastewater_structure ws
  LEFT JOIN qgep_od.vw_file file ON ws.obj_id = file.object
  WHERE file.kind = '3772'
  GROUP BY ws.obj_id;
