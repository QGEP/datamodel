CREATE OR REPLACE VIEW qgep_mobile.vw_manhole AS 
 SELECT DISTINCT ON (ws.obj_id) ws.obj_id,
    ws.identifier,
    (st_dump(ws.situation_geometry)).geom::geometry(Point,2056) AS situation_geometry,
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
    'false' AS verified,
    'false' AS deleted,
    NULL AS photo1,
    NULL AS photo2,
    NULL::smallint AS inlet_3_material,
    NULL::numeric(6, 3) AS inlet_3_dimension_mm,
    NULL::numeric(6, 3) AS inlet_3_depth_m,
    NULL::smallint AS inlet_4_material,
    NULL::numeric(6, 3) AS inlet_4_dimension_mm,
    NULL::numeric(6, 3) AS inlet_4_depth_m,
    NULL::smallint AS inlet_5_material,
    NULL::numeric(6, 3) AS inlet_5_dimension_mm,
    NULL::numeric(6, 3) AS inlet_5_depth_m,
    NULL::smallint AS inlet_6_material,
    NULL::numeric(6, 3) AS inlet_6_dimension_mm,
    NULL::numeric(6, 3) AS inlet_6_depth_m,
    NULL::smallint AS inlet_7_material,
    NULL::numeric(6, 3) AS inlet_7_dimension_mm,
    NULL::numeric(6, 3) AS inlet_7_depth_m,
    NULL::smallint AS outlet_1_material,
    NULL::numeric(6, 3) AS outlet_1_dimension_mm,
    NULL::numeric(6, 3) AS outlet_1_depth_m,
    NULL::smallint AS outlet_2_material,
    NULL::numeric(6, 3) AS outlet_2_dimension_mm,
    NULL::numeric(6, 3) AS outlet_2_depth_m
   FROM qgep_od.vw_qgep_wastewater_structure ws;


-- DROP TRIGGER qgep_mobile_vw_manhole_on_insert ON qgep_mobile.vw_manhole;

CREATE TRIGGER qgep_mobile_vw_manhole_on_insert
  INSTEAD OF INSERT
  ON qgep_mobile.vw_manhole
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.vw_manhole_insert();

-- DROP TRIGGER qgep_mobile_vw_manhole_on_update ON qgep_mobile.vw_manhole;

CREATE TRIGGER qgep_mobile_vw_manhole_on_update
  INSTEAD OF INSERT
  ON qgep_mobile.vw_manhole
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.vw_manhole_update();


DROP TABLE IF EXISTS qgep_mobile.manhole_quarantine;

CREATE TABLE qgep_mobile.manhole_quarantine
(
  obj_id character varying(16),
  identifier character varying(20),
  situation_geometry geometry(Point,2056),
  co_shape integer,
  co_diameter smallint,
  co_material integer,
  co_positional_accuracy integer,
  co_level numeric(7,3),
  _depth numeric(6,3),
  _channel_usage_current integer,
  ma_material integer,
  ma_dimension1 smallint,
  ma_dimension2 smallint,
  ws_type text,
  ma_function integer,
  ss_function integer,
  remark character varying(80),
  wn_bottom_level numeric(7,3),
  verified text,
  deleted text,
  photo1 text,
  photo2 text,
  inlet_3_material smallint,
  inlet_3_dimension_mm numeric(6,3),
  inlet_3_depth_m numeric(6,3),
  inlet_4_material smallint,
  inlet_4_dimension_mm numeric(6,3),
  inlet_4_depth_m numeric(6,3),
  inlet_5_material smallint,
  inlet_5_dimension_mm numeric(6,3),
  inlet_5_depth_m numeric(6,3),
  inlet_6_material smallint,
  inlet_6_dimension_mm numeric(6,3),
  inlet_6_depth_m numeric(6,3),
  inlet_7_material smallint,
  inlet_7_dimension_mm numeric(6,3),
  inlet_7_depth_m numeric(6,3),
  outlet_1_material smallint,
  outlet_1_dimension_mm numeric(6,3),
  outlet_1_depth_m numeric(6,3),
  outlet_2_material smallint,
  outlet_2_dimension_mm numeric(6,3),
  outlet_2_depth_m numeric(6,3)
)
