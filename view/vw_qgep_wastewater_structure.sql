-- View: vw_qgep_wastewater_structure

BEGIN TRANSACTION;

DROP VIEW IF EXISTS qgep_od.vw_qgep_wastewater_structure;

CREATE OR REPLACE VIEW qgep_od.vw_qgep_wastewater_structure AS
 SELECT 
    ws.obj_id,
    main_co.brand,
    main_co.cover_shape,
    main_co.diameter,
    main_co.fastening,
    main_co.level,
    main_co.material AS cover_material,
    main_co.positional_accuracy,
    aggregated_wastewater_structure.situation_geometry,
    main_co.sludge_bucket,
    main_co.venting,
    main_co_sp.identifier AS co_identifier,
    main_co_sp.remark,
    main_co_sp.renovation_demand,
    main_co_sp.last_modification,
    ws.fk_dataowner,
    ws.fk_provider,

    CASE
      WHEN mh.obj_id IS NOT NULL THEN 'manhole'
      WHEN ss.obj_id IS NOT NULL THEN 'special_structure'
      WHEN dp.obj_id IS NOT NULL THEN 'discharge_point'
      WHEN ii.obj_id IS NOT NULL THEN 'infiltration_installation'
      ELSE 'unknown'
    END AS ws_type,

    main_co.obj_id as co_obj_id,
    ws.identifier as identifier,
    ws.accessibility,
    ws.contract_section,
    ws.financing,
    ws.gross_costs,
    ws.inspection_interval,
    ws.location_name,
    ws.records,
    ws.remark AS ws_remark,
    ws.renovation_necessity,
    ws.replacement_value,
    ws.rv_base_year,
    ws.rv_construction_type,
    ws.status,
    ws.structure_condition,
    ws.subsidies,
    ws.year_of_construction,
    ws.year_of_replacement,
    ws.fk_owner,
    ws.fk_operator,
    ws._label,
    ws._depth,
    COALESCE( mh.dimension1, ii.dimension1 ) AS dimension1,
    COALESCE( mh.dimension2, ii.dimension2 ) AS dimension2,
    COALESCE( ss.upper_elevation, dp.upper_elevation, ii.upper_elevation ) AS upper_elevation,

    mh.function AS manhole_function,
    mh.material,
    mh.surface_inflow,

    ws._usage_current AS channel_usage_current,
    ws._function_hierarchic AS channel_function_hierarchic,
    mh._orientation AS manhole_orientation,

    ss.bypass,
    ss.function as special_structure_function,
    ss.stormwater_tank_arrangement,

    dp.highwater_level,
    dp.relevance,
    dp.terrain_level,
    dp.waterlevel_hydraulic,

    ii.absorption_capacity,
    ii.defects,
    ii.distance_to_aquifer,
    ii.effective_area,
    ii.emergency_spillway,
    ii.kind,
    ii.labeling,
    ii.seepage_utilization,
    ii.vehicle_access,
    ii.watertightness,

    wn.obj_id AS wn_obj_id,
    wn.backflow_level,
    wn.bottom_level,
    -- wn.situation_geometry ,
    wn.identifier AS wn_identifier,
    wn.remark AS wn_remark,
    wn.last_modification AS wn_last_modification,
    wn.fk_dataowner AS wn_fk_dataowner,
    wn.fk_provider AS wn_fk_provider

  FROM (
    SELECT ws.obj_id,
      ST_Collect(co.situation_geometry)::geometry(MultiPoint, :SRID) AS situation_geometry,
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
   LEFT JOIN qgep_od.manhole mh ON mh.obj_id = ws.obj_id
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
           , NEW.dimension1
           , NEW.dimension2
           , NEW.manhole_function
           , NEW.material
           , NEW.surface_inflow
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
           , NEW.bypass
           , NEW.emergency_spillway
           , NEW.special_structure_function
           , NEW.stormwater_tank_arrangement
           , NEW.upper_elevation
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
           , NEW.highwater_level
           , NEW.relevance
           , NEW.terrain_level
           , NEW.upper_elevation
           , NEW.waterlevel_hydraulic
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
           , NEW.absorption_capacity
           , NEW.defects
           , NEW.dimension1
           , NEW.dimension2
           , NEW.distance_to_aquifer
           , NEW.effective_area
           , NEW.emergency_spillway
           , NEW.kind
           , NEW.labeling
           , NEW.seepage_utilization
           , NEW.upper_elevation
           , NEW.vehicle_access
           , NEW.watertightness
           );
    ELSE
     RAISE NOTICE 'Wastewater structure type not known (%)', NEW.ws_type; -- ERROR
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
    , NEW.backflow_level
    , NEW.bottom_level
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
    , NEW.brand
    , NEW.cover_shape
    , NEW.diameter
    , NEW.fastening
    , NEW.level
    , NEW.cover_material
    , NEW.positional_accuracy
    , ST_GeometryN( NEW.situation_geometry, 1 )
    , NEW.sludge_bucket
    , NEW.venting
    , COALESCE(NULLIF(NEW.co_identifier,''), NEW.identifier)
    , NEW.remark
    , NEW.renovation_demand
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
        brand = NEW.brand,
        cover_shape = new.cover_shape,
        diameter = new.diameter,
        fastening = new.fastening,
        level = new.level,
        material = new.cover_material,
        positional_accuracy = new.positional_accuracy,
        sludge_bucket = new.sludge_bucket,
        venting = new.venting
    WHERE cover.obj_id::text = OLD.co_obj_id::text;

    UPDATE qgep_od.structure_part
      SET
        identifier = new.co_identifier,
        remark = new.remark,
        renovation_demand = new.renovation_demand,
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
        remark = NEW.ws_remark,
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
        dimension1 = NEW.dimension1,
        dimension2 = NEW.dimension2,
        function = NEW.manhole_function,
        material = NEW.material,
        surface_inflow = NEW.surface_inflow
      WHERE obj_id = OLD.obj_id;

    WHEN NEW.ws_type = 'special_structure' THEN
      UPDATE qgep_od.special_structure
      SET
        bypass = NEW.bypass,
        emergency_spillway = NEW.emergency_spillway,
        function = NEW.special_structure_function,
        stormwater_tank_arrangement = NEW.stormwater_tank_arrangement,
        upper_elevation = NEW.upper_elevation
      WHERE obj_id = OLD.obj_id;

    WHEN NEW.ws_type = 'discharge_point' THEN
      UPDATE qgep_od.discharge_point
      SET
        highwater_level = NEW.highwater_level,
        relevance = NEW.relevance,
        terrain_level = NEW.terrain_level,
        upper_elevation = NEW.upper_elevation,
        waterlevel_hydraulic = NEW.waterlevel_hydraulic
      WHERE obj_id = OLD.obj_id;

    WHEN NEW.ws_type = 'infiltration_installation' THEN
      UPDATE qgep_od.infiltration_installation
      SET
        absorption_capacity = NEW.absorption_capacity,
        defects = NEW.defects,
        dimension1 = NEW.dimension1,
        dimension2 = NEW.dimension2,
        distance_to_aquifer = NEW.distance_to_aquifer,
        effective_area = NEW.effective_area,
        emergency_spillway = NEW.emergency_spillway,
        kind = NEW.kind,
        labeling = NEW.labeling,
        seepage_utilization = NEW.seepage_utilization,
        upper_elevation = NEW.upper_elevation,
        vehicle_access = NEW.vehicle_access,
        watertightness = NEW.watertightness
      WHERE obj_id = OLD.obj_id;
  END CASE;

  UPDATE qgep_od.vw_wastewater_node NO1
    SET
    backflow_level = NEW.backflow_level
    , bottom_level = NEW.bottom_level
    -- , situation_geometry = NEW.situation_geometry -- Geometry is handled separately below
    , identifier = NEW.identifier
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
