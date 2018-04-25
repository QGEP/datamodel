-- View: vw_qgep_wastewater_structure

BEGIN TRANSACTION;

DROP VIEW IF EXISTS qgep_od.vw_qgep_wastewater_structure;

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
      ST_Collect(co.situation_geometry)::geometry(MultiPoint, %(SRID)s) AS situation_geometry,
      CASE WHEN COUNT(wn.obj_id) = 1 THEN MIN(wn.obj_id) ELSE NULL END AS wn_obj_id
    FROM qgep_od.wastewater_structure ws
    FULL OUTER JOIN qgep_od.structure_part sp ON sp.fk_wastewater_structure = ws.obj_id
    LEFT JOIN qgep_od.cover co ON co.obj_id = sp.obj_id
    LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.fk_wastewater_structure = ws.obj_id
    LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id = ne.obj_id
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

-- INSERT function

CREATE OR REPLACE FUNCTION qgep_od.vw_qgep_wastewater_structure_INSERT()
  RETURNS trigger AS
$BODY$
BEGIN

  NEW.identifier = COALESCE(NEW.identifier, NEW.obj_id);

  INSERT INTO qgep_od.wastewater_structure(
      obj_id
    , accessibility
    , contract_section
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
    , last_modification
    , fk_dataowner
    , fk_provider
    , fk_owner
    , fk_operator
  )
  VALUES
  (
      NEW.obj_id
    , NEW.accessibility
    , NEW.contract_section
    , NEW.financing
    , NEW.gross_costs
    , NEW.identifier
    , NEW.inspection_interval
    , NEW.location_name
    , NEW.records
    , NEW.remark
    , NEW.renovation_necessity
    , NEW.replacement_value
    , NEW.rv_base_year
    , NEW.rv_construction_type
    , NEW.status
    , NEW.structure_condition
    , NEW.subsidies
    , NEW.year_of_construction
    , NEW.year_of_replacement
    , NEW.last_modification
    , NEW.fk_dataowner
    , NEW.fk_provider
    , NEW.fk_owner
    , NEW.fk_operator
  );

  -- Manhole
  CASE
    WHEN NEW.ws_type = 'manhole' THEN
      INSERT INTO qgep_od.manhole(
             obj_id
           , dimension1
           , dimension2
           , function
           , material
           , surface_inflow
           )
           VALUES
           (
             NEW.obj_id
           , NEW.ma_dimension1
           , NEW.ma_dimension2
           , NEW.ma_function
           , NEW.ma_material
           , NEW.ma_surface_inflow
           );

    -- Special Structure
    WHEN NEW.ws_type = 'special_structure' THEN
      INSERT INTO qgep_od.special_structure(
             obj_id
           , bypass
           , emergency_spillway
           , function
           , stormwater_tank_arrangement
           , upper_elevation
           )
           VALUES
           (
             NEW.obj_id
           , NEW.ss_bypass
           , NEW.ss_emergency_spillway
           , NEW.ss_special_structure_function
           , NEW.ss_stormwater_tank_arrangement
           , NEW.ss_upper_elevation
           );

    -- Discharge Point
    WHEN NEW.ws_type = 'discharge_point' THEN
      INSERT INTO qgep_od.discharge_point(
             obj_id
           , highwater_level
           , relevance
           , terrain_level
           , upper_elevation
           , waterlevel_hydraulic
           )
           VALUES
           (
             NEW.obj_id
           , NEW.dp_highwater_level
           , NEW.dp_relevance
           , NEW.dp_terrain_level
           , NEW.dp_upper_elevation
           , NEW.dp_waterlevel_hydraulic
           );

    -- Infiltration Installation
    WHEN NEW.ws_type = 'infiltration_installation' THEN
      INSERT INTO qgep_od.infiltration_installation(
             obj_id
           , absorption_capacity
           , defects
           , dimension1
           , dimension2
           , distance_to_aquifer
           , effective_area
           , emergency_spillway
           , kind
           , labeling
           , seepage_utilization
           , upper_elevation
           , vehicle_access
           , watertightness
           )
           VALUES
           (
             NEW.obj_id
           , NEW.ii_absorption_capacity
           , NEW.ii_defects
           , NEW.ii_dimension1
           , NEW.ii_dimension2
           , NEW.ii_distance_to_aquifer
           , NEW.ii_effective_area
           , NEW.ii_emergency_spillway
           , NEW.ii_kind
           , NEW.ii_labeling
           , NEW.ii_seepage_utilization
           , NEW.ii_upper_elevation
           , NEW.ii_vehicle_access
           , NEW.ii_watertightness
           );
    ELSE
     RAISE NOTICE 'Wastewater structure type not known (%%)', NEW.ws_type; -- ERROR
  END CASE;

  INSERT INTO qgep_od.vw_wastewater_node(
      obj_id
    , backflow_level
    , bottom_level
    , situation_geometry
    , identifier
    , remark
    , last_modification
    , fk_dataowner
    , fk_provider
    , fk_wastewater_structure
  )
  VALUES
  (
      NEW.wn_obj_id
    , NEW.wn_backflow_level
    , NEW.wn_bottom_level
    , ST_GeometryN( NEW.situation_geometry, 1 )
    , COALESCE(NULLIF(NEW.wn_identifier,''), NEW.identifier)
    , NEW.wn_remark
    , NOW()
    , COALESCE(NULLIF(NEW.wn_fk_provider,''), NEW.fk_provider)
    , COALESCE(NULLIF(NEW.wn_fk_dataowner,''), NEW.fk_dataowner)
    , NEW.obj_id
  );

  INSERT INTO qgep_od.vw_cover(
      obj_id
    , brand
    , cover_shape
    , diameter
    , fastening
    , level
    , material
    , positional_accuracy
    , situation_geometry
    , sludge_bucket
    , venting
    , identifier
    , remark
    , renovation_demand
    , last_modification
    , fk_dataowner
    , fk_provider
    , fk_wastewater_structure
  )
  VALUES
  (
      NEW.co_obj_id
    , NEW.co_brand
    , NEW.co_shape
    , NEW.co_diameter
    , NEW.co_fastening
    , NEW.co_level
    , NEW.co_material
    , NEW.co_positional_accuracy
    , ST_GeometryN( NEW.situation_geometry, 1 )
    , NEW.co_sludge_bucket
    , NEW.co_venting
    , COALESCE(NULLIF(NEW.co_identifier,''), NEW.identifier)
    , NEW.co_remark
    , NEW.co_renovation_demand
    , NOW()
    , NEW.fk_dataowner
    , NEW.fk_provider
    , NEW.obj_id
  );

  UPDATE qgep_od.wastewater_structure
  SET fk_main_cover = NEW.co_obj_id
  WHERE obj_id = NEW.obj_id;

  RETURN NEW;
END; $BODY$ LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS vw_qgep_wastewater_structure_ON_INSERT ON qgep_od.vw_qgep_wastewater_structure;

CREATE TRIGGER vw_qgep_wastewater_structure_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_qgep_wastewater_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_wastewater_structure_INSERT();

/**************************************************************
 * UPDATE
 *************************************************************/
CREATE OR REPLACE FUNCTION qgep_od.vw_qgep_wastewater_structure_UPDATE()
  RETURNS trigger AS
$BODY$
DECLARE
  dx float;
  dy float;
BEGIN
    UPDATE qgep_od.cover
      SET
        brand = NEW.co_brand,
        cover_shape = new.co_shape,
        diameter = new.co_diameter,
        fastening = new.co_fastening,
        level = new.co_level,
        material = new.co_material,
        positional_accuracy = new.co_positional_accuracy,
        sludge_bucket = new.co_sludge_bucket,
        venting = new.co_venting
    WHERE cover.obj_id::text = OLD.co_obj_id::text;

    UPDATE qgep_od.structure_part
      SET
        identifier = new.co_identifier,
        remark = new.co_remark,
        renovation_demand = new.co_renovation_demand,
        last_modification = new.last_modification,
        fk_dataowner = new.fk_dataowner,
        fk_provider = new.fk_provider
    WHERE structure_part.obj_id::text = OLD.co_obj_id::text;

    UPDATE qgep_od.wastewater_structure
      SET
        obj_id = NEW.obj_id,
        identifier = NEW.identifier,
        accessibility = NEW.accessibility,
        contract_section = NEW.contract_section,
        financing = NEW.financing,
        gross_costs = NEW.gross_costs,
        inspection_interval = NEW.inspection_interval,
        location_name = NEW.location_name,
        records = NEW.records,
        remark = NEW.remark,
        renovation_necessity = NEW.renovation_necessity,
        replacement_value = NEW.replacement_value,
        rv_base_year = NEW.rv_base_year,
        rv_construction_type = NEW.rv_construction_type,
        status = NEW.status,
        structure_condition = NEW.structure_condition,
        subsidies = NEW.subsidies,
        year_of_construction = NEW.year_of_construction,
        year_of_replacement = NEW.year_of_replacement,
        fk_owner = NEW.fk_owner,
        fk_operator = NEW.fk_operator
     WHERE wastewater_structure.obj_id::text = OLD.obj_id::text;

  IF OLD.ws_type <> NEW.ws_type THEN
    CASE
      WHEN OLD.ws_type = 'manhole' THEN DELETE FROM qgep_od.manhole WHERE obj_id = OLD.obj_id;
      WHEN OLD.ws_type = 'special_structure' THEN DELETE FROM qgep_od.special_structure WHERE obj_id = OLD.obj_id;
      WHEN OLD.ws_type = 'discharge_point' THEN DELETE FROM qgep_od.discharge_point WHERE obj_id = OLD.obj_id;
      WHEN OLD.ws_type = 'infiltration_installation' THEN DELETE FROM qgep_od.infiltration_installation WHERE obj_id = OLD.obj_id;
    END CASE;

    CASE
      WHEN NEW.ws_type = 'manhole' THEN INSERT INTO qgep_od.manhole (obj_id) VALUES(OLD.obj_id);
      WHEN NEW.ws_type = 'special_structure' THEN INSERT INTO qgep_od.special_structure (obj_id) VALUES(OLD.obj_id);
      WHEN NEW.ws_type = 'discharge_point' THEN INSERT INTO qgep_od.discharge_point (obj_id) VALUES(OLD.obj_id);
      WHEN NEW.ws_type = 'infiltration_installation' THEN INSERT INTO qgep_od.infiltration_installation (obj_id) VALUES(OLD.obj_id);
    END CASE;
  END IF;

  CASE
    WHEN NEW.ws_type = 'manhole' THEN
      UPDATE qgep_od.manhole
      SET
        dimension1 = NEW.ma_dimension1,
        dimension2 = NEW.ma_dimension2,
        function = NEW.ma_function,
        material = NEW.ma_material,
        surface_inflow = NEW.ma_surface_inflow
      WHERE obj_id = OLD.obj_id;

    WHEN NEW.ws_type = 'special_structure' THEN
      UPDATE qgep_od.special_structure
      SET
        bypass = NEW.ss_bypass,
        emergency_spillway = NEW.ss_emergency_spillway,
        function = NEW.ss_function,
        stormwater_tank_arrangement = NEW.ss_stormwater_tank_arrangement,
        upper_elevation = NEW.ss_upper_elevation
      WHERE obj_id = OLD.obj_id;

    WHEN NEW.ws_type = 'discharge_point' THEN
      UPDATE qgep_od.discharge_point
      SET
        highwater_level = NEW.dp_highwater_level,
        relevance = NEW.dp_relevance,
        terrain_level = NEW.dp_terrain_level,
        upper_elevation = NEW.dp_upper_elevation,
        waterlevel_hydraulic = NEW.dp_waterlevel_hydraulic
      WHERE obj_id = OLD.obj_id;

    WHEN NEW.ws_type = 'infiltration_installation' THEN
      UPDATE qgep_od.infiltration_installation
      SET
        absorption_capacity = NEW.ii_absorption_capacity,
        defects = NEW.ii_defects,
        dimension1 = NEW.ii_dimension1,
        dimension2 = NEW.ii_dimension2,
        distance_to_aquifer = NEW.ii_distance_to_aquifer,
        effective_area = NEW.ii_effective_area,
        emergency_spillway = NEW.ii_emergency_spillway,
        kind = NEW.ii_kind,
        labeling = NEW.ii_labeling,
        seepage_utilization = NEW.ii_seepage_utilization,
        upper_elevation = NEW.ii_upper_elevation,
        vehicle_access = NEW.ii_vehicle_access,
        watertightness = NEW.ii_watertightness
      WHERE obj_id = OLD.obj_id;
  END CASE;

  UPDATE qgep_od.vw_wastewater_node NO1
    SET
    backflow_level = NEW.wn_backflow_level
    , bottom_level = NEW.wn_bottom_level
    -- , situation_geometry = NEW.situation_geometry -- Geometry is handled separately below
    , identifier = NEW.wn_identifier
    , remark = NEW.wn_remark
    -- , last_modification -- Handled by triggers
    , fk_dataowner = NEW.fk_dataowner
    , fk_provider = NEW.fk_provider
    -- Only update if there is a single wastewater node on this structure
    WHERE fk_wastewater_structure = NEW.obj_id AND
    (
      SELECT COUNT(*)
      FROM qgep_od.vw_wastewater_node NO2
      WHERE NO2.fk_wastewater_structure = NO1.fk_wastewater_structure
    ) = 1;

  -- Cover geometry has been moved
  IF NOT ST_Equals( OLD.situation_geometry, NEW.situation_geometry) THEN
    dx = ST_XMin(NEW.situation_geometry) - ST_XMin(OLD.situation_geometry);
    dy = ST_YMin(NEW.situation_geometry) - ST_YMin(OLD.situation_geometry);

    -- Move wastewater node as well
    UPDATE qgep_od.wastewater_node WN
    SET situation_geometry = ST_TRANSLATE(WN.situation_geometry, dx, dy )
    WHERE obj_id IN
    (
      SELECT obj_id FROM qgep_od.wastewater_networkelement
      WHERE fk_wastewater_structure = NEW.obj_id
    );

    -- Move covers
    UPDATE qgep_od.cover CO
    SET situation_geometry = ST_TRANSLATE(CO.situation_geometry, dx, dy )
    WHERE obj_id IN
    (
      SELECT obj_id FROM qgep_od.structure_part
      WHERE fk_wastewater_structure = NEW.obj_id
    );

    -- Move reach(es) as well
    UPDATE qgep_od.reach RE
    SET progression_geometry =
      ST_ForceCurve (ST_SetPoint(
        ST_CurveToLine (RE.progression_geometry ),
        0, -- SetPoint index is 0 based, PointN index is 1 based.
        ST_TRANSLATE(ST_PointN(RE.progression_geometry, 1), dx, dy )
      ) )
    WHERE fk_reach_point_from IN
    (
      SELECT RP.obj_id FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      WHERE NE.fk_wastewater_structure = NEW.obj_id
    );

    UPDATE qgep_od.reach RE
    SET progression_geometry =
      ST_ForceCurve( ST_SetPoint(
        ST_CurveToLine( RE.progression_geometry ),
        ST_NumPoints(RE.progression_geometry) - 1,
        ST_TRANSLATE(ST_EndPoint(RE.progression_geometry), dx, dy )
      ) )
    WHERE fk_reach_point_to IN
    (
      SELECT RP.obj_id FROM qgep_od.reach_point RP
      LEFT JOIN qgep_od.wastewater_networkelement NE ON RP.fk_wastewater_networkelement = NE.obj_id
      WHERE NE.fk_wastewater_structure = NEW.obj_id
    );
  END IF;

  RETURN NEW;
END; $BODY$ LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS vw_qgep_wastewater_structure_ON_UPDATE ON qgep_od.vw_qgep_wastewater_structure;

CREATE TRIGGER vw_qgep_wastewater_structure_ON_UPDATE INSTEAD OF UPDATE ON qgep_od.vw_qgep_wastewater_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_wastewater_structure_UPDATE();


/**************************************************************
 * DELETE
 *************************************************************/

CREATE OR REPLACE FUNCTION qgep_od.vw_qgep_wastewater_structure_DELETE()
  RETURNS trigger AS
$BODY$
DECLARE
BEGIN
  DELETE FROM qgep_od.wastewater_structure WHERE obj_id = OLD.obj_id;
RETURN OLD;
END; $BODY$ LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS vw_qgep_wastewater_structure_ON_DELETE ON qgep_od.vw_qgep_wastewater_structure;

CREATE TRIGGER vw_qgep_wastewater_structure_ON_DELETE INSTEAD OF DELETE ON qgep_od.vw_qgep_wastewater_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_qgep_wastewater_structure_DELETE();

/**************************************************************
 * DEFAULT VALUES
 *************************************************************/

ALTER VIEW qgep_od.vw_qgep_wastewater_structure ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','wastewater_structure');
ALTER VIEW qgep_od.vw_qgep_wastewater_structure ALTER co_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','structure_part');


END TRANSACTION;
