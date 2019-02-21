-----------------------------------------------
-----------------------------------------------
-- UPDATE GEOMETRY OF qgep_od.reach_point
-----------------------------------------------
-----------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS qgep_od.vw_network_segment;
DROP MATERIALIZED VIEW IF EXISTS qgep_od.vw_network_node;
DROP VIEW IF EXISTS qgep_od.vw_qgep_reach;
DROP VIEW IF EXISTS qgep_od.vw_change_points;

ALTER TABLE qgep_od.reach_point ALTER COLUMN situation_geometry TYPE geometry('POINTZ', %(SRID)s) USING ST_SetSRID( ST_MakePoint( ST_X(situation_geometry), ST_Y(situation_geometry), COALESCE(level,'NaN') ), %(SRID)s);




-----------------------------------------------
-----------------------------------------------
-- UPDATE GEOMETRY OF qgep_od.wastewater_node
-----------------------------------------------
-----------------------------------------------
DROP VIEW IF EXISTS qgep_od.vw_qgep_overflow;
DROP VIEW IF EXISTS qgep_od.vw_catchment_area_connections;
DROP VIEW IF EXISTS qgep_import.vw_manhole;
DROP VIEW IF EXISTS qgep_od.vw_qgep_wastewater_structure;
DROP VIEW IF EXISTS qgep_od.vw_wastewater_node;

ALTER TABLE qgep_od.wastewater_node ALTER COLUMN situation_geometry TYPE geometry('POINTZ', %(SRID)s) USING ST_SetSRID( ST_MakePoint( ST_X(situation_geometry), ST_Y(situation_geometry), COALESCE(bottom_level,'NaN') ), %(SRID)s);
-- in quarantine we do not add the level to the geometry because this will be done on insert on table - so it's always 'NaN'
ALTER TABLE qgep_import.manhole_quarantine ALTER COLUMN situation_geometry TYPE geometry('POINTZ', %(SRID)s) USING ST_SetSRID( ST_MakePoint( ST_X(situation_geometry), ST_Y(situation_geometry), 'NaN' ), %(SRID)s);




-----------------------------------------------
-----------------------------------------------
-- UPDATE GEOMETRY OF qgep_od.cover
-----------------------------------------------
-----------------------------------------------
DROP VIEW IF EXISTS qgep_od.vw_cover;

ALTER TABLE qgep_od.cover ALTER COLUMN situation_geometry TYPE geometry('POINTZ', %(SRID)s) USING ST_SetSRID( ST_MakePoint( ST_X(situation_geometry), ST_Y(situation_geometry), COALESCE(level,'NaN') ), %(SRID)s);




-----------------------------------------------
-----------------------------------------------
-- RECREATE DEPENDENCIES OF qgep_od.reach_point
-----------------------------------------------
-----------------------------------------------
-- View: qgep_od.vw_network_node
-----------------------------------------------

CREATE MATERIALIZED VIEW qgep_od.vw_network_node AS
 SELECT
   row_number() OVER () AS gid,
   nodes.*
 FROM
 (
   SELECT
     obj_id,
     'reach_point' AS type,
     'reach_point' AS node_type,
     level AS level,
     NULL AS usage_current,
     NULL AS cover_level,
     NULL AS backflow_level,
     NULL AS description,
     situation_geometry::geometry(POINTZ,%(SRID)s) AS detail_geometry,
     situation_geometry::geometry(POINTZ,%(SRID)s)
   FROM qgep_od.reach_point

   UNION

   SELECT
     NE.obj_id,
     'wastewater_node' AS type,
     CASE
       WHEN MH.obj_id IS NOT NULL
         THEN 'manhole'
       WHEN WS.obj_id IS NOT NULL
         THEN 'special_WSucture'
       ELSE 'other'
     END AS node_type,
     bottom_level AS level,
     COALESCE( MAX( ch_from.usage_current ), MAX( ch_to.usage_current ) ) AS usage_current,
     MAX( CO.level ) AS cover_level,
     WN.backflow_level AS backflow_level,
     NE.identifier AS description,
     COALESCE( WS.detail_geometry_geometry, WN.situation_geometry ) AS detail_geometry, -- Will contain different geometry types: do not visualize directly. Will be handled by plugin
     WN.situation_geometry
   FROM qgep_od.wastewater_node WN
   LEFT JOIN qgep_od.wastewater_networkelement NE
     ON NE.obj_id = WN.obj_id
   LEFT JOIN qgep_od.wastewater_structure WS
     ON WS.obj_id = NE.fk_wastewater_structure
   LEFT JOIN qgep_od.manhole MH
     ON MH.obj_id = WS.obj_id
   LEFT JOIN qgep_od.structure_part SP
     ON SP.fk_wastewater_structure = WS.obj_id
   LEFT JOIN qgep_od.cover CO
     ON CO.obj_id = SP.obj_id
   LEFT JOIN qgep_od.reach_point RP
     ON NE.obj_id = RP.fk_wastewater_networkelement
   LEFT JOIN qgep_od.reach re_from
     ON re_from.fk_reach_point_from = RP.obj_id
   LEFT JOIN qgep_od.wastewater_networkelement ne_from
     ON ne_from.obj_id = re_from.obj_id
   LEFT JOIN qgep_od.channel ch_from
     ON ch_from.obj_id = ne_from.fk_wastewater_structure
   LEFT JOIN qgep_od.reach re_to
     ON re_to.fk_reach_point_to = RP.obj_id
   LEFT JOIN qgep_od.wastewater_networkelement ne_to
     ON ne_to.obj_id = re_to.obj_id
   LEFT JOIN qgep_od.channel ch_to
     ON ch_to.obj_id = ne_to.fk_wastewater_structure
   GROUP BY NE.obj_id, type, bottom_level, backflow_level, description, WN.situation_geometry, WS.detail_geometry_geometry, WS.obj_id, MH.obj_id, SP.fk_wastewater_structure
  ) AS nodes;




-----------------------------------------------
-- View: qgep_od.vw_network_segment
-----------------------------------------------

CREATE MATERIALIZED VIEW qgep_od.vw_network_segment AS
 WITH reach_parts AS (
   SELECT
     row_number() OVER (ORDER BY reach_point.fk_wastewater_networkelement, ST_LineLocatePoint(ST_LineMerge(ST_CurveToLine(ST_Force2D(reach.progression_geometry))), reach_point.situation_geometry)) AS gid,
     reach_point.obj_id,
     reach_point.fk_wastewater_networkelement,
     reach_point.situation_geometry,
     reach.progression_geometry,
     reach.fk_reach_point_from,
     reach.fk_reach_point_to,
     ST_LineMerge(ST_CurveToLine(ST_Force2D(reach.progression_geometry))) AS reach_progression,
     ST_LineLocatePoint(
       ST_LineMerge(ST_CurveToLine(ST_Force2D(reach.progression_geometry))),
       reach_point.situation_geometry
     ) AS pos
   FROM qgep_od.reach_point
   LEFT JOIN qgep_od.reach ON reach_point.fk_wastewater_networkelement::text = reach.obj_id::text
   WHERE reach_point.fk_wastewater_networkelement IS NOT NULL AND reach.progression_geometry IS NOT NULL
   ORDER BY reach_point.obj_id, ST_LineLocatePoint(ST_LineMerge(ST_CurveToLine(reach.progression_geometry)), reach_point.situation_geometry)
 )

 SELECT row_number() OVER () AS gid,
   parts.*
 FROM
 (
   SELECT
     re.obj_id,
     'reach' AS type,
     clear_height,
     ST_Length( COALESCE( reach_progression, progression_geometry ) ) AS length_calc,
     ST_Length( progression_geometry ) AS length_full,
     COALESCE( from_obj_id, fk_reach_point_from ) AS from_obj_id,
     COALESCE( to_obj_id, fk_reach_point_to ) AS to_obj_id,
     fk_reach_point_from AS from_obj_id_interpolate,
     fk_reach_point_to AS to_obj_id_interpolate,
     COALESCE( from_pos, 0 ) AS from_pos,
     COALESCE( to_pos, 1 ) AS to_pos,
     NULL AS bottom_level,
     ch.usage_current AS usage_current,
     mat.abbr_de AS material,
     COALESCE(reach_progression, ST_LineMerge(ST_CurveToLine(ST_Force2D(progression_geometry)))) AS progression_geometry,
     ST_LineMerge(ST_CurveToLine(ST_Force2D(progression_geometry)))::geometry(LineString,%(SRID)s) AS detail_geometry
   FROM qgep_od.reach re
   FULL JOIN
   (
     SELECT
       COALESCE(s1.fk_wastewater_networkelement, s2.fk_wastewater_networkelement) AS reach_obj_id,
       COALESCE(s1.obj_id, s2.fk_reach_point_from) AS from_obj_id,
       COALESCE(s2.obj_id, s1.fk_reach_point_to) AS to_obj_id,
       COALESCE(s1.pos, 0::double precision) AS from_pos,
       COALESCE(s2.pos, 1::double precision) AS to_pos,
       ST_LineSubstring(COALESCE(s1.reach_progression, s2.reach_progression),
                        COALESCE(s1.pos, 0::double precision),
                        COALESCE(s2.pos, 1::double precision)) AS reach_progression
     FROM reach_parts s1
     FULL JOIN reach_parts s2 ON s1.gid = (s2.gid - 1) AND s1.fk_wastewater_networkelement::text = s2.fk_wastewater_networkelement::text
     ORDER BY COALESCE(s1.fk_wastewater_networkelement, s2.fk_wastewater_networkelement), COALESCE(s1.pos, 0::double precision)
   ) AS rr
   ON rr.reach_obj_id = re.obj_id
   LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = re.obj_id
   LEFT JOIN qgep_od.channel ch ON ch.obj_id = ne.fk_wastewater_structure
   LEFT JOIN qgep_vl.reach_material mat ON re.material = mat.code

   UNION

   SELECT
     connectors.obj_id AS obj_id,
     'special_structure' AS type,
     NULL AS depth,
     ST_Length( progression_geometry ) AS length_calc,
     ST_Length( progression_geometry ) AS length_full,
     from_obj_id,
     to_obj_id,
     from_obj_id AS from_obj_id_interpolate,
     to_obj_id AS to_obj_id_interpolate,
     0 AS from_pos,
     1 AS to_pos,
     bottom_level,
     NULL AS usage_current,
     NULL AS material,
     progression_geometry,
     progression_geometry AS detail_geometry

   FROM
   (
     SELECT
     wn_from.obj_id AS obj_id,
     wn_from.obj_id AS from_obj_id,
     rp_from.obj_id AS to_obj_id,
     wn_from.bottom_level AS bottom_level,
     ST_LineFromMultiPoint( ST_Collect(wn_from.situation_geometry, rp_from.situation_geometry ) ) AS progression_geometry
     FROM qgep_od.reach
       LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id = reach.fk_reach_point_from
       LEFT JOIN qgep_od.wastewater_node wn_from ON rp_from.fk_wastewater_networkelement = wn_from.obj_id
     WHERE
       reach.fk_reach_point_from IS NOT NULL
       AND
       wn_from.obj_id IS NOT NULL

     UNION

     SELECT
       wn_to.obj_id AS obj_id,
       rp_to.obj_id AS from_obj_id,
       wn_to.obj_id AS to_obj_id,
       wn_to.bottom_level AS bottom_level,
       ST_LineFromMultiPoint( ST_Collect(rp_to.situation_geometry, wn_to.situation_geometry ) ) AS progression_geometry
     FROM qgep_od.reach
       LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id = reach.fk_reach_point_to
       LEFT JOIN qgep_od.wastewater_node wn_to ON rp_to.fk_wastewater_networkelement = wn_to.obj_id
     WHERE
       reach.fk_reach_point_to IS NOT NULL
     AND
       wn_to.obj_id IS NOT NULL
   ) AS connectors
   LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = connectors.obj_id
 ) AS parts
WHERE GeometryType(progression_geometry) <> 'GEOMETRYCOLLECTION';




REFRESH MATERIALIZED view qgep_od.vw_network_node;
REFRESH MATERIALIZED view qgep_od.vw_network_segment;




-----------------------------------------------
-- View: qgep_od.vw_qgep_reach and rules and triggers
-----------------------------------------------

CREATE OR REPLACE VIEW qgep_od.vw_qgep_reach AS

/* WITH active_maintenance_event AS (
  SELECT me.obj_id, me.identifier, me.active_zone, mews.fk_wastewater_structure FROM qgep_od.maintenance_event me
  LEFT JOIN
    qgep_od.re_maintenance_event_wastewater_structure mews ON mews.fk_maintenance_event = me.obj_id
    WHERE active_zone IS NOT NULL
) */

SELECT re.obj_id,
    re.clear_height AS clear_height,
    re.material,
    ch.usage_current AS ch_usage_current,
    ch.function_hierarchic AS ch_function_hierarchic,
    ws.status AS ws_status,
    ws.fk_owner AS ws_fk_owner,
    ch.function_hydraulic AS ch_function_hydraulic,
    CASE WHEN pp.height_width_ratio IS NOT NULL THEN round(re.clear_height::numeric * pp.height_width_ratio)::smallint ELSE clear_height END AS width,
    re.coefficient_of_friction,
    re.elevation_determination,
    re.horizontal_positioning,
    re.inside_coating,
    re.length_effective,
    CASE WHEN rp_from.level > 0 AND rp_to.level > 0 THEN round((rp_from.level - rp_to.level)/re.length_effective*1000,1) ELSE NULL END AS _slope_per_mill,
    re.progression_geometry,
    re.reliner_material,
    re.reliner_nominal_size,
    re.relining_construction,
    re.relining_kind,
    re.ring_stiffness,
    re.slope_building_plan,
    re.wall_roughness,
    re.fk_pipe_profile,
    ne.identifier,
    ne.remark,
    ne.last_modification,
    ne.fk_dataowner,
    ne.fk_provider,
    ne.fk_wastewater_structure,
    ch.bedding_encasement AS ch_bedding_encasement,
    ch.connection_type AS ch_connection_type,
    ch.jetting_interval AS ch_jetting_interval,
    ch.pipe_length AS ch_pipe_length,
    ch.usage_planned AS ch_usage_planned,
    ws.obj_id AS ws_obj_id,
    ws.accessibility AS ws_accessibility,
    ws.contract_section AS ws_contract_section,
    ws.financing AS ws_financing,
    ws.gross_costs AS ws_gross_costs,
    ws.identifier AS ws_identifier,
    ws.inspection_interval AS ws_inspection_interval,
    ws.location_name AS ws_location_name,
    ws.records AS ws_records,
    ws.remark AS ws_remark,
    ws.renovation_necessity AS ws_renovation_necessity,
    ws.replacement_value AS ws_replacement_value,
    ws.rv_base_year AS ws_rv_base_year,
    ws.rv_construction_type AS ws_rv_construction_type,
    ws.structure_condition AS ws_structure_condition,
    ws.subsidies AS ws_subsidies,
    ws.year_of_construction AS ws_year_of_construction,
    ws.year_of_replacement AS ws_year_of_replacement,
    ws.fk_operator AS ws_fk_operator,
    rp_from.obj_id AS rp_from_obj_id,
    rp_from.elevation_accuracy AS rp_from_elevation_accuracy,
    rp_from.identifier AS rp_from_identifier,
    rp_from.level AS rp_from_level,
    rp_from.outlet_shape AS rp_from_outlet_shape,
    rp_from.position_of_connection AS rp_from_position_of_connection,
    rp_from.remark AS rp_from_remark,
    rp_from.last_modification AS rp_from_last_modification,
    rp_from.fk_dataowner AS rp_from_fk_dataowner,
    rp_from.fk_provider AS rp_from_fk_provider,
    rp_from.fk_wastewater_networkelement AS rp_from_fk_wastewater_networkelement,
    rp_to.obj_id AS rp_to_obj_id,
    rp_to.elevation_accuracy AS rp_to_elevation_accuracy,
    rp_to.identifier AS rp_to_identifier,
    rp_to.level AS rp_to_level,
    rp_to.outlet_shape AS rp_to_outlet_shape,
    rp_to.position_of_connection AS rp_to_position_of_connection,
    rp_to.remark AS rp_to_remark,
    rp_to.last_modification AS rp_to_last_modification,
    rp_to.fk_dataowner AS rp_to_fk_dataowner,
    rp_to.fk_provider AS rp_to_fk_provider,
    rp_to.fk_wastewater_networkelement AS rp_to_fk_wastewater_networkelement
    /* am.obj_id AS me_obj_id,
    am.active_zone AS me_active_zone,
    am.identifier AS me_identifier */
   FROM qgep_od.reach re
     LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = re.obj_id
     LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id = re.fk_reach_point_from
     LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id = re.fk_reach_point_to
     LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure = ws.obj_id
     LEFT JOIN qgep_od.channel ch ON ch.obj_id = ws.obj_id
     LEFT JOIN qgep_od.pipe_profile pp ON re.fk_pipe_profile = pp.obj_id;
     /* LEFT JOIN active_maintenance_event am ON am.fk_wastewater_structure = ch.obj_id; */

-- REACH INSERT
-- Trigger: vw_qgep_reach_on_insert()
-- Comment: triggerfunction need not anymore to force 2d
-- REACH INSERT
-- Function: vw_qgep_reach_insert()


CREATE OR REPLACE FUNCTION qgep_od.vw_qgep_reach_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  -- Synchronize geometry with level
  NEW.progression_geometry = ST_ForceCurve(ST_SetPoint(ST_CurveToLine(NEW.progression_geometry),0,
  ST_MakePoint(ST_X(ST_StartPoint(NEW.progression_geometry)),ST_Y(ST_StartPoint(NEW.progression_geometry)),COALESCE(NEW.rp_from_level,'NaN'))));
  
  NEW.progression_geometry = ST_ForceCurve(ST_SetPoint(ST_CurveToLine(NEW.progression_geometry),ST_NumPoints(NEW.progression_geometry)-1,
  ST_MakePoint(ST_X(ST_EndPoint(NEW.progression_geometry)),ST_Y(ST_EndPoint(NEW.progression_geometry)),COALESCE(NEW.rp_to_level,'NaN'))));

  INSERT INTO qgep_od.reach_point(
            obj_id
            , elevation_accuracy
            , identifier
            , level
            , outlet_shape
            , position_of_connection
            , remark
            , situation_geometry
            , last_modification
            , fk_dataowner
            , fk_provider
            , fk_wastewater_networkelement
          )
    VALUES (
            COALESCE(NEW.rp_from_obj_id,qgep_sys.generate_oid('qgep_od','reach_point')) -- obj_id
            , NEW.rp_from_elevation_accuracy -- elevation_accuracy
            , NEW.rp_from_identifier -- identifier
            , NEW.rp_from_level -- level
            , NEW.rp_from_outlet_shape -- outlet_shape
            , NEW.rp_from_position_of_connection -- position_of_connection
            , NEW.rp_from_remark -- remark
            , ST_StartPoint(NEW.progression_geometry) -- situation_geometry
            , NEW.rp_from_last_modification -- last_modification
            , NEW.rp_from_fk_dataowner -- fk_dataowner
            , NEW.rp_from_fk_provider -- fk_provider
            , NEW.rp_from_fk_wastewater_networkelement -- fk_wastewater_networkelement
          )
    RETURNING obj_id INTO NEW.rp_from_obj_id;


    INSERT INTO qgep_od.reach_point(
            obj_id
            , elevation_accuracy
            , identifier
            , level
            , outlet_shape
            , position_of_connection
            , remark
            , situation_geometry
            , last_modification
            , fk_dataowner
            , fk_provider
            , fk_wastewater_networkelement
          )
    VALUES (
            COALESCE(NEW.rp_to_obj_id,qgep_sys.generate_oid('qgep_od','reach_point')) -- obj_id
            , NEW.rp_to_elevation_accuracy -- elevation_accuracy
            , NEW.rp_to_identifier -- identifier
            , NEW.rp_to_level -- level
            , NEW.rp_to_outlet_shape -- outlet_shape
            , NEW.rp_to_position_of_connection -- position_of_connection
            , NEW.rp_to_remark -- remark
            , ST_EndPoint(NEW.progression_geometry) -- situation_geometry
            , NEW.rp_to_last_modification -- last_modification
            , NEW.rp_to_fk_dataowner -- fk_dataowner
            , NEW.rp_to_fk_provider -- fk_provider
            , NEW.rp_to_fk_wastewater_networkelement -- fk_wastewater_networkelement
          )
    RETURNING obj_id INTO NEW.rp_to_obj_id;

  INSERT INTO qgep_od.wastewater_structure (
            obj_id
            , accessibility
            , contract_section
            -- , detail_geometry_geometry
            , financing
            , gross_costs
            , identifier
            , inspection_interval
            , location_name
            , records
            , remark
            , renovation_necessity
            , replacement_value
            , rv_base_year
            , rv_construction_type
            , status
            , structure_condition
            , subsidies
            , year_of_construction
            , year_of_replacement
            -- , last_modification
            -- , fk_dataowner
            -- , fk_provider
            , fk_owner
            , fk_operator )

    VALUES ( COALESCE(NEW.fk_wastewater_structure,qgep_sys.generate_oid('qgep_od','channel')) -- obj_id
            , NEW.ws_accessibility
            , NEW.ws_contract_section
            -- , NEW.detail_geometry_geometry
            , NEW.ws_financing
            , NEW.ws_gross_costs
            , NEW.ws_identifier
            , NEW.ws_inspection_interval
            , NEW.ws_location_name
            , NEW.ws_records
            , NEW.ws_remark
            , NEW.ws_renovation_necessity
            , NEW.ws_replacement_value
            , NEW.ws_rv_base_year
            , NEW.ws_rv_construction_type
            , NEW.ws_status
            , NEW.ws_structure_condition
            , NEW.ws_subsidies
            , NEW.ws_year_of_construction
            , NEW.ws_year_of_replacement
            -- , NEW.ws_last_modification
            -- , NEW.fk_dataowner
            -- , NEW.fk_provider
            , NEW.ws_fk_owner
            , NEW.ws_fk_operator
           )
           RETURNING obj_id INTO NEW.fk_wastewater_structure;

  INSERT INTO qgep_od.channel(
              obj_id
            , bedding_encasement
            , connection_type
            , function_hierarchic
            , function_hydraulic
            , jetting_interval
            , pipe_length
            , usage_current
            , usage_planned
            )
            VALUES(
              NEW.fk_wastewater_structure
            , NEW.ch_bedding_encasement
            , NEW.ch_connection_type
            , NEW.ch_function_hierarchic
            , NEW.ch_function_hydraulic
            , NEW.ch_jetting_interval
            , NEW.ch_pipe_length
            , NEW.ch_usage_current
            , NEW.ch_usage_planned
            );

  INSERT INTO qgep_od.wastewater_networkelement (
            obj_id
            , identifier
            , remark
            , last_modification
            , fk_dataowner
            , fk_provider
            , fk_wastewater_structure )
    VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','reach')) -- obj_id
            , NEW.identifier -- identifier
            , NEW.remark -- remark
            , NEW.last_modification -- last_modification
            , NEW.fk_dataowner -- fk_dataowner
            , NEW.fk_provider -- fk_provider
            , NEW.fk_wastewater_structure -- fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

  INSERT INTO qgep_od.reach (
            obj_id
            , clear_height
            , coefficient_of_friction
            , elevation_determination
            , horizontal_positioning
            , inside_coating
            , length_effective
            , material
            , progression_geometry
            , reliner_material
            , reliner_nominal_size
            , relining_construction
            , relining_kind
            , ring_stiffness
            , slope_building_plan
            , wall_roughness
            , fk_reach_point_from
            , fk_reach_point_to
            , fk_pipe_profile )
    VALUES(
              NEW.obj_id -- obj_id
            , NEW.clear_height
            , NEW.coefficient_of_friction
            , NEW.elevation_determination
            , NEW.horizontal_positioning
            , NEW.inside_coating
            , NEW.length_effective
            , NEW.material
            , NEW.progression_geometry
            , NEW.reliner_material
            , NEW.reliner_nominal_size
            , NEW.relining_construction
            , NEW.relining_kind
            , NEW.ring_stiffness
            , NEW.slope_building_plan
            , NEW.wall_roughness
            , NEW.rp_from_obj_id
            , NEW.rp_to_obj_id
            , NEW.fk_pipe_profile);

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TRIGGER vw_qgep_reach_on_insert INSTEAD OF INSERT ON qgep_od.vw_qgep_reach
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_reach_insert();

-- REACH UPDATE
-- Function: vw_qgep_reach_update()

CREATE OR REPLACE FUNCTION qgep_od.vw_qgep_reach_on_update()
  RETURNS trigger AS
$BODY$
BEGIN

  -- Synchronize geometry with level
  IF NEW.rp_from_level <> OLD.rp_from_level OR (NEW.rp_from_level IS NULL AND OLD.rp_from_level IS NOT NULL) OR (NEW.rp_from_level IS NOT NULL AND OLD.rp_from_level IS NULL) THEN
    NEW.progression_geometry = ST_ForceCurve(ST_SetPoint(ST_CurveToLine(NEW.progression_geometry),0,
    ST_MakePoint(ST_X(ST_StartPoint(NEW.progression_geometry)),ST_Y(ST_StartPoint(NEW.progression_geometry)),COALESCE(NEW.rp_from_level,'NaN'))));
  ELSE 
    IF ST_Z(ST_StartPoint(NEW.progression_geometry)) <> ST_Z(ST_StartPoint(OLD.progression_geometry)) THEN
      NEW.rp_from_level = NULLIF(ST_Z(ST_StartPoint(NEW.progression_geometry)),'NaN');
    END IF;
  END IF;

  -- Synchronize geometry with level
  IF NEW.rp_to_level <> OLD.rp_to_level OR (NEW.rp_to_level IS NULL AND OLD.rp_to_level IS NOT NULL) OR (NEW.rp_to_level IS NOT NULL AND OLD.rp_to_level IS NULL) THEN
    NEW.progression_geometry = ST_ForceCurve(ST_SetPoint(ST_CurveToLine(NEW.progression_geometry),ST_NumPoints(NEW.progression_geometry)-1,
    ST_MakePoint(ST_X(ST_EndPoint(NEW.progression_geometry)),ST_Y(ST_EndPoint(NEW.progression_geometry)),COALESCE(NEW.rp_to_level,'NaN'))));
  ELSE 
    IF ST_Z(ST_EndPoint(NEW.progression_geometry)) <> ST_Z(ST_EndPoint(OLD.progression_geometry)) THEN
      NEW.rp_to_level = NULLIF(ST_Z(ST_EndPoint(NEW.progression_geometry)),'NaN');
    END IF;
  END IF;

  UPDATE qgep_od.reach_point
    SET
        elevation_accuracy = NEW.rp_from_elevation_accuracy
      , identifier = NEW.rp_from_identifier
      , level = NEW.rp_from_level
      , outlet_shape = NEW.rp_from_outlet_shape
      , position_of_connection = NEW.rp_from_position_of_connection
      , remark = NEW.rp_from_remark
      , situation_geometry = ST_StartPoint(NEW.progression_geometry)
      , last_modification = NEW.rp_from_last_modification
      , fk_dataowner = NEW.rp_from_fk_dataowner
      , fk_provider = NEW.rp_from_fk_provider
      , fk_wastewater_networkelement = NEW.rp_from_fk_wastewater_networkelement
    WHERE obj_id = OLD.rp_from_obj_id;

  UPDATE qgep_od.reach_point
    SET
        elevation_accuracy = NEW.rp_to_elevation_accuracy
      , identifier = NEW.rp_to_identifier
      , level = NEW.rp_to_level
      , outlet_shape = NEW.rp_to_outlet_shape
      , position_of_connection = NEW.rp_to_position_of_connection
      , remark = NEW.rp_to_remark
      , situation_geometry = ST_EndPoint(NEW.progression_geometry)
      , last_modification = NEW.rp_to_last_modification
      , fk_dataowner = NEW.rp_to_fk_dataowner
      , fk_provider = NEW.rp_to_fk_provider
      , fk_wastewater_networkelement = NEW.rp_to_fk_wastewater_networkelement
    WHERE obj_id = OLD.rp_to_obj_id;

  UPDATE qgep_od.channel
    SET
       bedding_encasement = NEW.ch_bedding_encasement
     , connection_type = NEW.ch_connection_type
     , function_hierarchic = NEW.ch_function_hierarchic
     , function_hydraulic = NEW.ch_function_hydraulic
     , jetting_interval = NEW.ch_jetting_interval
     , pipe_length = NEW.ch_pipe_length
     , usage_current = NEW.ch_usage_current
     , usage_planned = NEW.ch_usage_planned
  WHERE obj_id = OLD.fk_wastewater_structure;

  UPDATE qgep_od.wastewater_structure
    SET
       accessibility = NEW.ws_accessibility
     , contract_section = NEW.ws_contract_section
     -- , detail_geometry_geometry = NEW.detail_geometry_geometry
     , financing = NEW.ws_financing
     , gross_costs = NEW.ws_gross_costs
     , identifier = NEW.ws_identifier
     , inspection_interval = NEW.ws_inspection_interval
     , location_name = NEW.ws_location_name
     , records = NEW.ws_records
     , remark = NEW.ws_remark
     , renovation_necessity = NEW.ws_renovation_necessity
     , replacement_value = NEW.ws_replacement_value
     , rv_base_year = NEW.ws_rv_base_year
     , rv_construction_type = NEW.ws_rv_construction_type
     , status = NEW.ws_status
     , structure_condition = NEW.ws_structure_condition
     , subsidies = NEW.ws_subsidies
     , year_of_construction = NEW.ws_year_of_construction
     , year_of_replacement = NEW.ws_year_of_replacement
     , fk_dataowner = NEW.fk_dataowner
     , fk_provider = NEW.fk_provider
     , last_modification = NEW.last_modification
     , fk_owner = NEW.ws_fk_owner
     , fk_operator = NEW.ws_fk_operator
  WHERE obj_id = OLD.fk_wastewater_structure;


  UPDATE qgep_od.wastewater_networkelement
    SET
        identifier = NEW.identifier
      , remark = NEW.remark
      , last_modification = NEW.last_modification
      , fk_dataowner = NEW.fk_dataowner
      , fk_provider = NEW.fk_provider
      , fk_wastewater_structure = NEW.fk_wastewater_structure
    WHERE obj_id = OLD.obj_id;

  UPDATE qgep_od.reach
    SET clear_height = NEW.clear_height
      , coefficient_of_friction = NEW.coefficient_of_friction
      , elevation_determination = NEW.elevation_determination
      , horizontal_positioning = NEW.horizontal_positioning
      , inside_coating = NEW.inside_coating
      , length_effective = NEW.length_effective
      , material = NEW.material
      , progression_geometry = NEW.progression_geometry
      , reliner_material = NEW.reliner_material
      , reliner_nominal_size = NEW.reliner_nominal_size
      , relining_construction = NEW.relining_construction
      , relining_kind = NEW.relining_kind
      , ring_stiffness = NEW.ring_stiffness
      , slope_building_plan = NEW.slope_building_plan
      , wall_roughness = NEW.wall_roughness
      , fk_pipe_profile = NEW.fk_pipe_profile
    WHERE obj_id = OLD.obj_id;
    
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER vw_qgep_reach_on_update
  INSTEAD OF UPDATE
  ON qgep_od.vw_qgep_reach
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.vw_qgep_reach_on_update();

-- REACH DELETE
-- Rule: vw_qgep_reach_on_delete()

CREATE OR REPLACE RULE vw_qgep_reach_on_delete AS ON DELETE TO qgep_od.vw_qgep_reach DO INSTEAD (
  DELETE FROM qgep_od.reach WHERE obj_id = OLD.obj_id;
);

--missing: delete also connected wastewater_structure (and subclass channel or other), structure_parts, re_maintenance_events

ALTER VIEW qgep_od.vw_qgep_reach ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','reach');

ALTER VIEW qgep_od.vw_qgep_reach ALTER rp_from_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','reach_point');
ALTER VIEW qgep_od.vw_qgep_reach ALTER rp_to_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','reach_point');
ALTER VIEW qgep_od.vw_qgep_reach ALTER fk_wastewater_structure SET DEFAULT qgep_sys.generate_oid('qgep_od','channel');



-----------------------------------------------
-- View: qgep_od.vw_change_points
-----------------------------------------------
CREATE VIEW qgep_od.vw_change_points AS
SELECT
  rp_to.obj_id,
  rp_to.situation_geometry::geometry(POINTZ, %(SRID)s) AS geom,
  re.material <> re_next.material AS change_in_material,
  re.clear_height <> re_next.clear_height AS change_in_clear_height,
  (rp_from.level - rp_to.level) / re.length_effective - (rp_next_from.level - rp_next_to.level) / re_next.length_effective AS change_in_slope
FROM qgep_od.reach re
LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id = re.fk_reach_point_to
LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id = re.fk_reach_point_from
LEFT JOIN qgep_od.reach re_next ON rp_to.fk_wastewater_networkelement = re_next.obj_id
LEFT JOIN qgep_od.reach_point rp_next_to ON rp_next_to.obj_id = re_next.fk_reach_point_to
LEFT JOIN qgep_od.reach_point rp_next_from ON rp_next_from.obj_id = re_next.fk_reach_point_from
LEFT JOIN qgep_od.wastewater_networkelement ne ON re.obj_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_networkelement ne_next ON re_next.obj_id = ne_next.obj_id
WHERE ne_next.fk_wastewater_structure = ne.fk_wastewater_structure;




-----------------------------------------------
-----------------------------------------------
-- RECREATE DEPENDENCIES OF qgep_od.wastewaternode
-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- View: qgep_od.vw_qgep_overflow and triggers
-----------------------------------------------
-- Comment: this is originally created by python function and not by script - hope this works:

CREATE OR REPLACE VIEW qgep_od.vw_qgep_overflow AS 
 SELECT
        CASE
            WHEN leapingweir.obj_id IS NOT NULL THEN 'leapingweir'::qgep_od.overflow_type
            WHEN prank_weir.obj_id IS NOT NULL THEN 'prank_weir'::qgep_od.overflow_type
            WHEN pump.obj_id IS NOT NULL THEN 'pump'::qgep_od.overflow_type
            ELSE 'overflow'::qgep_od.overflow_type
        END AS overflow_type,
    overflow.obj_id,
    overflow.actuation,
    overflow.adjustability,
    overflow.brand,
    overflow.control,
    overflow.discharge_point,
    overflow.function,
    overflow.gross_costs,
    overflow.identifier,
    overflow.qon_dim,
    overflow.remark,
    overflow.signal_transmission,
    overflow.subsidies,
    overflow.last_modification,
    overflow.fk_dataowner,
    overflow.fk_provider,
    overflow.fk_wastewater_node,
    overflow.fk_overflow_to,
    overflow.fk_overflow_characteristic,
    overflow.fk_control_center,
    st_makeline(n1.situation_geometry, n2.situation_geometry)::geometry(LineString,%(SRID)s) AS geometry,
    leapingweir.length,
    leapingweir.opening_shape,
    leapingweir.width,
    prank_weir.hydraulic_overflow_length,
    prank_weir.level_max,
    prank_weir.level_min,
    prank_weir.weir_edge,
    prank_weir.weir_kind,
    pump.contruction_type,
    pump.operating_point,
    pump.placement_of_actuation,
    pump.placement_of_pump,
    pump.pump_flow_max_single,
    pump.pump_flow_min_single,
    pump.start_level,
    pump.stop_level,
    pump.usage_current
   FROM qgep_od.overflow overflow
     LEFT JOIN qgep_od.leapingweir leapingweir ON overflow.obj_id::text = leapingweir.obj_id::text
     LEFT JOIN qgep_od.prank_weir prank_weir ON overflow.obj_id::text = prank_weir.obj_id::text
     LEFT JOIN qgep_od.pump pump ON overflow.obj_id::text = pump.obj_id::text
     LEFT JOIN qgep_od.wastewater_node n1 ON overflow.fk_wastewater_node::text = n1.obj_id::text
     LEFT JOIN qgep_od.wastewater_node n2 ON overflow.fk_overflow_to::text = n2.obj_id::text;

ALTER TABLE qgep_od.vw_qgep_overflow
  OWNER TO postgres;

-- Trigger: tr_vw_qgep_overflow_delete on qgep_od.vw_qgep_overflow
CREATE TRIGGER tr_vw_qgep_overflow_delete
  INSTEAD OF DELETE
  ON qgep_od.vw_qgep_overflow
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.ft_vw_qgep_overflow_delete();

-- Trigger: tr_vw_qgep_overflow_insert on qgep_od.vw_qgep_overflow
CREATE TRIGGER tr_vw_qgep_overflow_insert
  INSTEAD OF INSERT
  ON qgep_od.vw_qgep_overflow
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.ft_vw_qgep_overflow_insert();

-- Trigger: tr_vw_qgep_overflow_update on qgep_od.vw_qgep_overflow
CREATE TRIGGER tr_vw_qgep_overflow_update
  INSTEAD OF UPDATE
  ON qgep_od.vw_qgep_overflow
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.ft_vw_qgep_overflow_update();



-----------------------------------------------
-- View: qgep_od.vw_catchment_area_connections
-----------------------------------------------
CREATE VIEW qgep_od.vw_catchment_area_connections AS
SELECT

ca.obj_id,
ST_MakeLine(ST_Centroid(ST_CurveToLine(perimeter_geometry)),
wn_rw_current.situation_geometry)::geometry( LineString, %(SRID)s ) AS connection_rw_current_geometry,
ST_MakeLine(ST_Centroid(ST_CurveToLine(perimeter_geometry)),
wn_ww_current.situation_geometry)::geometry( LineString, %(SRID)s ) AS connection_ww_current_geometry

FROM qgep_od.catchment_area ca
LEFT JOIN qgep_od.wastewater_node wn_rw_current
ON ca.fk_wastewater_networkelement_rw_current = wn_rw_current.obj_id
LEFT JOIN qgep_od.wastewater_node wn_ww_current
ON ca.fk_wastewater_networkelement_ww_current = wn_ww_current.obj_id;



-----------------------------------------------
-- View: qgep_od.vw_wastewater_node
-----------------------------------------------
CREATE OR REPLACE VIEW qgep_od.vw_wastewater_node AS

SELECT
   WN.obj_id
   , WN.backflow_level
   , WN.bottom_level
   , WN.situation_geometry
   , WE.identifier
   , WE.remark
   , WE.fk_dataowner
   , WE.fk_provider
   , WE.last_modification
  , WE.fk_wastewater_structure
  FROM qgep_od.wastewater_node WN
 LEFT JOIN qgep_od.wastewater_networkelement WE
 ON WE.obj_id = WN.obj_id;


ALTER TABLE qgep_od.vw_wastewater_node ALTER COLUMN obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od'::text, 'wastewater_node'::text);

-- Comment: only trigger - function is still existing
CREATE TRIGGER vw_wastewater_node_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_wastewater_node
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_wastewater_node_insert();

-- Rule: vw_wastewater_node_ON_UPDATE()
CREATE OR REPLACE RULE vw_wastewater_node_ON_UPDATE AS ON UPDATE TO qgep_od.vw_wastewater_node DO INSTEAD (
UPDATE qgep_od.wastewater_node
  SET
       backflow_level = NEW.backflow_level
     , bottom_level = NEW.bottom_level
     , situation_geometry = NEW.situation_geometry
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.wastewater_networkelement
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-- Rule: vw_wastewater_node_ON_DELETE ()
CREATE OR REPLACE RULE vw_wastewater_node_ON_DELETE AS ON DELETE TO qgep_od.vw_wastewater_node DO INSTEAD (
  DELETE FROM qgep_od.wastewater_node WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.wastewater_networkelement WHERE obj_id = OLD.obj_id;
);



-----------------------------------------------
-- qgep_od.vw_qgep_wastewater_structure
-----------------------------------------------
CREATE OR REPLACE VIEW qgep_od.vw_qgep_wastewater_structure AS
 SELECT
    ws.identifier as identifier,

    CASE
      WHEN ma.obj_id IS NOT NULL THEN 'manhole'
      WHEN ss.obj_id IS NOT NULL THEN 'special_structure'
      WHEN dp.obj_id IS NOT NULL THEN 'discharge_point'
      WHEN ii.obj_id IS NOT NULL THEN 'infiltration_installation'
      ELSE 'unknown'
    END AS ws_type,
    ma.function AS ma_function,
    ss.function as ss_function,
    ws.fk_owner,
    ws.status,

    ws.accessibility,
    ws.contract_section,
    ws.financing,
    ws.gross_costs,
    ws.inspection_interval,
    ws.location_name,
    ws.records,
    ws.remark,
    ws.renovation_necessity,
    ws.replacement_value,
    ws.rv_base_year,
    ws.rv_construction_type,
    ws.structure_condition,
    ws.subsidies,
    ws.year_of_construction,
    ws.year_of_replacement,
    ws.last_modification,
    ws.fk_operator,
    ws.fk_dataowner,
    ws.fk_provider,
    ws._depth,
    ws.obj_id,

   main_co_sp.identifier AS co_identifier,
   main_co.brand AS co_brand,
   main_co.cover_shape AS co_shape,
   main_co.diameter AS co_diameter,
   main_co.fastening AS co_fastening,
   main_co.level AS co_level,
   main_co.material AS co_material,
   main_co.positional_accuracy AS co_positional_accuracy,
   aggregated_wastewater_structure.situation_geometry,
   main_co.sludge_bucket AS co_sludge_bucket,
   main_co.venting AS co_venting,
   main_co_sp.remark AS co_remark,
   main_co_sp.renovation_demand AS co_renovation_demand,
   main_co.obj_id AS co_obj_id,

   ma.material AS ma_material,
   ma.surface_inflow AS ma_surface_inflow,
   ma.dimension1 AS ma_dimension1,
   ma.dimension2 AS ma_dimension2,
   ma._orientation AS ma_orientation,

   ss.bypass AS ss_bypass,
   ss.emergency_spillway AS ss_emergency_spillway,
   ss.stormwater_tank_arrangement AS ss_stormwater_tank_arrangement,
   ss.upper_elevation AS ss_upper_elevation,

   ii.absorption_capacity AS ii_absorption_capacity,
   ii.defects AS ii_defects,
   ii.dimension1 AS ii_dimension1,
   ii.dimension2 AS ii_dimension2,
   ii.distance_to_aquifer AS ii_distance_to_aquifer,
   ii.effective_area AS ii_effective_area,
   ii.emergency_spillway AS ii_emergency_spillway,
   ii.kind AS ii_kind,
   ii.labeling AS ii_labeling,
   ii.seepage_utilization AS ii_seepage_utilization,
   ii.upper_elevation AS ii_upper_elevation,
   ii.vehicle_access AS ii_vehicle_access,
   ii.watertightness AS ii_watertightness,

   dp.highwater_level AS dp_highwater_level,
   dp.relevance AS dp_relevance,
   dp.terrain_level AS dp_terrain_level,
   dp.upper_elevation AS dp_upper_elevation,
   dp.waterlevel_hydraulic AS dp_waterlevel_hydraulic,

   wn.identifier AS wn_identifier,
   wn.obj_id AS wn_obj_id,
   wn.backflow_level AS wn_backflow_level,
   wn.bottom_level AS wn_bottom_level,
   -- wn.situation_geometry ,
   wn.remark AS wn_remark,
   wn.last_modification AS wn_last_modification,
   wn.fk_dataowner AS wn_fk_dataowner,
   wn.fk_provider AS wn_fk_provider,

   ws._label,
   ws._usage_current AS _channel_usage_current,
   ws._function_hierarchic AS _channel_function_hierarchic

  FROM (
    SELECT ws.obj_id,
      ST_Collect(co.situation_geometry)::geometry(MULTIPOINTZ, %(SRID)s) AS situation_geometry,
      CASE WHEN COUNT(wn.obj_id) = 1 THEN MIN(wn.obj_id) ELSE NULL END AS wn_obj_id
    FROM qgep_od.wastewater_structure ws
    FULL OUTER JOIN qgep_od.structure_part sp ON sp.fk_wastewater_structure = ws.obj_id
    LEFT JOIN qgep_od.cover co ON co.obj_id = sp.obj_id
    RIGHT JOIN qgep_od.wastewater_networkelement ne ON ne.fk_wastewater_structure = ws.obj_id
    RIGHT JOIN qgep_od.wastewater_node wn ON wn.obj_id = ne.obj_id
    GROUP BY ws.obj_id
   ) aggregated_wastewater_structure
   LEFT JOIN qgep_od.wastewater_structure ws ON ws.obj_id = aggregated_wastewater_structure.obj_id
   LEFT JOIN qgep_od.cover main_co ON main_co.obj_id = ws.fk_main_cover
   LEFT JOIN qgep_od.structure_part main_co_sp ON main_co_sp.obj_id = ws.fk_main_cover
   LEFT JOIN qgep_od.manhole ma ON ma.obj_id = ws.obj_id
   LEFT JOIN qgep_od.special_structure ss ON ss.obj_id = ws.obj_id
   LEFT JOIN qgep_od.discharge_point dp ON dp.obj_id = ws.obj_id
   LEFT JOIN qgep_od.infiltration_installation ii ON ii.obj_id = ws.obj_id
   LEFT JOIN qgep_od.vw_wastewater_node wn ON wn.obj_id = aggregated_wastewater_structure.wn_obj_id;

-- Comment: only trigger - function is still existing
CREATE TRIGGER vw_qgep_wastewater_structure_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_qgep_wastewater_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_wastewater_structure_INSERT();

-- Comment: only trigger - function is still existing
CREATE TRIGGER vw_qgep_wastewater_structure_ON_UPDATE INSTEAD OF UPDATE ON qgep_od.vw_qgep_wastewater_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_wastewater_structure_UPDATE();

-- Comment: only trigger - function is still existing
CREATE TRIGGER vw_qgep_wastewater_structure_ON_DELETE INSTEAD OF DELETE ON qgep_od.vw_qgep_wastewater_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_wastewater_structure_DELETE();

ALTER VIEW qgep_od.vw_qgep_wastewater_structure ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','wastewater_structure');
ALTER VIEW qgep_od.vw_qgep_wastewater_structure ALTER co_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','structure_part');



-----------------------------------------------
-- qgep_import.vw_manhole
-----------------------------------------------

CREATE OR REPLACE VIEW qgep_import.vw_manhole AS 
 SELECT DISTINCT ON (ws.obj_id) ws.obj_id,
    ws.identifier,
    (st_dump(ws.situation_geometry)).geom::geometry(POINTZ,%(SRID)s) AS situation_geometry,
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
    NULL::integer AS inlet_3_clear_height,
    NULL::numeric(7, 3) AS inlet_3_depth_m,
    NULL::smallint AS inlet_4_material,
    NULL::integer AS inlet_4_clear_height,
    NULL::numeric(7, 3) AS inlet_4_depth_m,
    NULL::smallint AS inlet_5_material,
    NULL::integer AS inlet_5_clear_height,
    NULL::numeric(7, 3) AS inlet_5_depth_m,
    NULL::smallint AS inlet_6_material,
    NULL::integer AS inlet_6_clear_height,
    NULL::numeric(7, 3) AS inlet_6_depth_m,
    NULL::smallint AS inlet_7_material,
    NULL::integer AS inlet_7_clear_height,
    NULL::numeric(7, 3) AS inlet_7_depth_m,
    NULL::smallint AS outlet_1_material,
    NULL::integer AS outlet_1_clear_height,
    NULL::numeric(7, 3) AS outlet_1_depth_m,
    NULL::smallint AS outlet_2_material,
    NULL::integer AS outlet_2_clear_height,
    NULL::numeric(7, 3) AS outlet_2_depth_m,
    FALSE::boolean AS verified,
    (CASE WHEN EXISTS ( SELECT TRUE FROM qgep_import.manhole_quarantine q WHERE q.obj_id = ws.obj_id )
    THEN TRUE
    ELSE FALSE 
    END) AS in_quarantine,
    FALSE::boolean AS deleted

   FROM qgep_od.vw_qgep_wastewater_structure ws;

-- Comment: triggerfunction has to be rewritten because of Z coordinate 
CREATE OR REPLACE FUNCTION qgep_import.manhole_quarantine_try_structure_update() RETURNS trigger AS $BODY$
DECLARE 
  multi_situation_geometry geometry(MULTIPOINTZ,%(SRID)s);
BEGIN
  multi_situation_geometry = st_collect(NEW.situation_geometry)::geometry(MULTIPOINTZ,%(SRID)s);

  -- in case there is a depth, but no refercing value - it should stay in quarantene
  IF( NEW._depth IS NOT NULL AND NEW.co_level IS NULL AND NEW.wn_bottom_level IS NULL ) THEN
    RAISE EXCEPTION 'No referencing value for calculation with depth';
  END IF;

  -- qgep_od.wastewater_structure
  IF( SELECT TRUE FROM qgep_od.vw_qgep_wastewater_structure WHERE obj_id = NEW.obj_id ) THEN
    UPDATE qgep_od.vw_qgep_wastewater_structure SET
    identifier = NEW.identifier,
    situation_geometry = multi_situation_geometry,
    co_shape = NEW.co_shape,
    co_diameter = NEW.co_diameter,
    co_material = NEW.co_material,
    co_positional_accuracy = NEW.co_positional_accuracy,
    co_level = 
      (CASE WHEN NEW.co_level IS NULL AND NEW.wn_bottom_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.wn_bottom_level + NEW._depth
      ELSE NEW.co_level
      END),
    _depth = NEW._depth,
    _channel_usage_current = NEW._channel_usage_current,
    ma_material = NEW.ma_material,
    ma_dimension1 = NEW.ma_dimension1,
    ma_dimension2 = NEW.ma_dimension2,
    ws_type = NEW.ws_type,
    ma_function = NEW.ma_function,
    ss_function = NEW.ss_function,
    remark = NEW.remark,
    wn_bottom_level = 
      (CASE WHEN NEW.wn_bottom_level IS NULL AND NEW.co_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.co_level - NEW._depth
      ELSE NEW.wn_bottom_level
      END)
    WHERE obj_id = NEW.obj_id;
    RAISE NOTICE 'Updated row in qgep_od.vw_qgep_wastewater_structure';
  ELSE
    INSERT INTO qgep_od.vw_qgep_wastewater_structure
    (
    obj_id,
    identifier,
    situation_geometry,
    co_shape,
    co_diameter,
    co_material,
    co_positional_accuracy,
    co_level,
    _depth,
    _channel_usage_current,
    ma_material,
    ma_dimension1,
    ma_dimension2,
    ws_type,
    ma_function,
    ss_function,
    remark,
    wn_bottom_level
    )
    VALUES
    (
    NEW.obj_id,
    NEW.identifier,
    multi_situation_geometry,
    NEW.co_shape,
    NEW.co_diameter,
    NEW.co_material,
    NEW.co_positional_accuracy,
      (CASE WHEN NEW.co_level IS NULL AND NEW.wn_bottom_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.wn_bottom_level + NEW._depth
      ELSE NEW.co_level
      END),
    NEW._depth,
    NEW._channel_usage_current,
    NEW.ma_material,
    NEW.ma_dimension1,
    NEW.ma_dimension2,
    NEW.ws_type,
    NEW.ma_function,
    NEW.ss_function,
    NEW.remark,
      (CASE WHEN NEW.wn_bottom_level IS NULL AND NEW.co_level IS NOT NULL AND NEW._depth IS NOT NULL
      THEN NEW.co_level - NEW._depth
      ELSE NEW.wn_bottom_level
      END)
      );
    RAISE NOTICE 'Inserted row in qgep_od.vw_qgep_wastewater_structure';
  END IF;

  -- photo1 insert
  IF (NEW.photo1 IS NOT NULL) THEN
    INSERT INTO qgep_od.file
    (
      object,
      identifier
    )
    VALUES
    ( 
      NEW.obj_id,
      NEW.photo1
    );
    RAISE NOTICE 'Inserted row in qgep_od.file';
  END IF;

  -- photo2 insert
  IF (NEW.photo2 IS NOT NULL) THEN
    INSERT INTO qgep_od.file
    (
      object,
      identifier
    )
    VALUES
    ( 
      NEW.obj_id,
      NEW.photo2
    );
    RAISE NOTICE 'Inserted row in qgep_od.file';
  END IF;

  -- set structure okay
  UPDATE qgep_import.manhole_quarantine
  SET structure_okay = true
  WHERE quarantine_serial = NEW.quarantine_serial;
  RETURN NEW;

  -- catch
  EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'EXCEPTION: %%', SQLERRM;
    RETURN NEW;
END; $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER on_mutation_make_insert_or_delete
  INSTEAD OF INSERT OR UPDATE
  ON qgep_import.vw_manhole
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_import.vw_manhole_insert_into_quarantine_or_delete();



-----------------------------------------------
-----------------------------------------------
-- RECREATE DEPENDENCIES OF qgep_od.cover
-----------------------------------------------
-----------------------------------------------
-- View: qgep_od.vw_cover
-----------------------------------------------
CREATE OR REPLACE VIEW qgep_od.vw_cover AS

SELECT
   CO.obj_id
   , CO.brand
   , CO.cover_shape
   , CO.diameter
   , CO.fastening
   , CO.level
   , CO.material
   , CO.positional_accuracy
   , CO.situation_geometry
   , CO.sludge_bucket
   , CO.venting
   , SP.identifier
   , SP.remark
   , SP.renovation_demand
   , SP.fk_dataowner
   , SP.fk_provider
   , SP.last_modification
  , SP.fk_wastewater_structure
  FROM qgep_od.cover CO
 LEFT JOIN qgep_od.structure_part SP
 ON SP.obj_id = CO.obj_id;

-- Comment: only trigger - function is still existing
CREATE TRIGGER vw_cover_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_cover
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_cover_insert();

-- Rule: vw_cover_ON_UPDATE()
CREATE OR REPLACE RULE vw_cover_ON_UPDATE AS ON UPDATE TO qgep_od.vw_cover DO INSTEAD (
UPDATE qgep_od.cover
  SET
       brand = NEW.brand
     , cover_shape = NEW.cover_shape
     , diameter = NEW.diameter
     , fastening = NEW.fastening
     , level = NEW.level
     , material = NEW.material
     , positional_accuracy = NEW.positional_accuracy
     , situation_geometry = NEW.situation_geometry
     , sludge_bucket = NEW.sludge_bucket
     , venting = NEW.venting
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.structure_part
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , renovation_demand = NEW.renovation_demand
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-- Rule: vw_cover_ON_DELETE ()
CREATE OR REPLACE RULE vw_cover_ON_DELETE AS ON DELETE TO qgep_od.vw_cover DO INSTEAD (
  DELETE FROM qgep_od.cover WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.structure_part WHERE obj_id = OLD.obj_id;
);


-----------------------------------------------
-----------------------------------------------
-- Synchronize GEOMETRY with bottom_level qgep_od.wastewater_node
-----------------------------------------------
-----------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.synchronize_level_with_altitude_on_wastewater_node()
  RETURNS trigger AS
$BODY$
BEGIN
  CASE
    WHEN TG_OP = 'INSERT' THEN
      NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.bottom_level,'NaN') ), %(SRID)s);
    WHEN TG_OP = 'UPDATE' THEN
      IF NEW.bottom_level <> OLD.bottom_level OR (NEW.bottom_level IS NULL AND OLD.bottom_level IS NOT NULL) OR (NEW.bottom_level IS NOT NULL AND OLD.bottom_level IS NULL) THEN
        NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.bottom_level,'NaN') ), %(SRID)s);
      ELSE 
        IF ST_Z(NEW.situation_geometry) <> ST_Z(OLD.situation_geometry) THEN
          NEW.bottom_level = NULLIF(ST_Z(NEW.situation_geometry),'NaN');
        END IF;
      END IF;
  END CASE;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS synchronize_level_with_altitude ON qgep_od.wastewater_node;

CREATE TRIGGER synchronize_level_with_altitude
  BEFORE INSERT OR UPDATE
  ON qgep_od.wastewater_node
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.synchronize_level_with_altitude_on_wastewater_node();


-----------------------------------------------
-----------------------------------------------
-- Synchronize GEOMETRY with level qgep_od.cover
-----------------------------------------------
-----------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.synchronize_level_with_altitude_on_cover()
  RETURNS trigger AS
$BODY$
BEGIN
  CASE
    WHEN TG_OP = 'INSERT' THEN
      NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.level,'NaN') ), %(SRID)s);
    WHEN TG_OP = 'UPDATE' THEN
      IF NEW.level <> OLD.level OR (NEW.level IS NULL AND OLD.level IS NOT NULL) OR (NEW.level IS NOT NULL AND OLD.level IS NULL) THEN
        NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.level,'NaN') ), %(SRID)s);
      ELSE 
        IF ST_Z(NEW.situation_geometry) <> ST_Z(OLD.situation_geometry) THEN
          NEW.level = NULLIF(ST_Z(NEW.situation_geometry),'NaN');
        END IF;
      END IF;
  END CASE;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS synchronize_level_with_altitude ON qgep_od.cover;

CREATE TRIGGER synchronize_level_with_altitude
  BEFORE INSERT OR UPDATE
  ON qgep_od.cover
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.synchronize_level_with_altitude_on_cover();
