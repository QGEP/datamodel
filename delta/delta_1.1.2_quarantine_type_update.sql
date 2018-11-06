-- recreate mobile view with correct types in null values
DROP VIEW IF EXISTS qgep_import.vw_manhole;

CREATE OR REPLACE VIEW qgep_import.vw_manhole AS 
 SELECT DISTINCT ON (ws.obj_id) ws.obj_id,
    ws.identifier,
    (st_dump(ws.situation_geometry)).geom::geometry(Point,%(SRID)s) AS situation_geometry,
    ws.co_shape,
    ws.co_diameter,
    ws.co_material,
    ws.co_positional_accuracy,
    ws.co_level,
    ws._depth::numeric(6, 3) AS _depth,
    ws._channel_usage_current,
    ws.ma_material,
    ws.ma_dimension1,
    ws.ma_dimension2,
    ws.ws_type,
    ws.ma_function,
    ws.ss_function,
    ws.remark,
    ws.wn_bottom_level,
    NULL::text AS photo1,
    NULL::text AS photo2,
    NULL::smallint AS inlet_3_material,
    NULL::integer AS inlet_3_clear_hight,
    NULL::numeric(7, 3) AS inlet_3_depth_m,
    NULL::smallint AS inlet_4_material,
    NULL::integer AS inlet_4_clear_hight,
    NULL::numeric(7, 3) AS inlet_4_depth_m,
    NULL::smallint AS inlet_5_material,
    NULL::integer AS inlet_5_clear_hight,
    NULL::numeric(7, 3) AS inlet_5_depth_m,
    NULL::smallint AS inlet_6_material,
    NULL::integer AS inlet_6_clear_hight,
    NULL::numeric(7, 3) AS inlet_6_depth_m,
    NULL::smallint AS inlet_7_material,
    NULL::integer AS inlet_7_clear_hight,
    NULL::numeric(7, 3) AS inlet_7_depth_m,
    NULL::smallint AS outlet_1_material,
    NULL::integer AS outlet_1_clear_hight,
    NULL::numeric(7, 3) AS outlet_1_depth_m,
    NULL::smallint AS outlet_2_material,
    NULL::integer AS outlet_2_clear_hight,
    NULL::numeric(7, 3) AS outlet_2_depth_m,
    FALSE::boolean AS verified,
    (CASE WHEN EXISTS ( SELECT TRUE FROM qgep_import.manhole_quarantine q WHERE q.obj_id = ws.obj_id )
    THEN TRUE
    ELSE FALSE 
    END) AS in_quarantine,
    FALSE::boolean AS deleted

   FROM qgep_od.vw_qgep_wastewater_structure ws;


CREATE TRIGGER on_mutation_make_insert_or_delete
  INSTEAD OF INSERT OR UPDATE
  ON qgep_import.vw_manhole
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.vw_manhole_insert_into_quarantine_or_delete();


-- change types of quarantene table

ALTER TABLE qgep_import.manhole_quarantine
ALTER COLUMN inlet_3_clear_hight TYPE integer,
ALTER COLUMN inlet_3_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_4_clear_hight TYPE integer,
ALTER COLUMN inlet_4_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_5_clear_hight TYPE integer,
ALTER COLUMN inlet_5_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_6_clear_hight TYPE integer,
ALTER COLUMN inlet_6_depth_m TYPE numeric(7,3),
ALTER COLUMN inlet_7_clear_hight TYPE integer,
ALTER COLUMN inlet_7_depth_m TYPE numeric(7,3),
ALTER COLUMN outlet_1_clear_hight TYPE integer,
ALTER COLUMN outlet_1_depth_m TYPE numeric(7,3),
ALTER COLUMN outlet_2_clear_hight TYPE integer,
ALTER COLUMN outlet_2_depth_m TYPE numeric(7,3);