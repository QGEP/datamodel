-- View: vw_qgep_cover

BEGIN TRANSACTION;

DROP VIEW IF EXISTS qgep.vw_qgep_cover;

CREATE OR REPLACE VIEW qgep.vw_qgep_cover AS
 SELECT co.obj_id,
    co.brand,
    co.cover_shape,
    co.diameter,
    co.fastening,
    co.level,
    co.material AS cover_material,
    co.positional_accuracy,
    co.situation_geometry,
    co.sludge_bucket,
    co.venting,
    co.identifier,
    co.remark,
    co.renovation_demand,
    co.last_modification,
    co.dataowner,
    co.provider,

    CASE
      WHEN mh.obj_id IS NOT NULL THEN 'manhole'
      WHEN ss.obj_id IS NOT NULL THEN 'special_structure'
      WHEN dp.obj_id IS NOT NULL THEN 'discharge_point'
      WHEN ii.obj_id IS NOT NULL THEN 'infiltration_installation'
      ELSE 'unknown'
    END AS ws_type,

    ws.obj_id as ws_obj_id,
    ws.identifier as ws_identifier,
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

    COALESCE( mh.depth, ss.depth, dp.depth, ii.depth ) AS depth,
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
    wn.dataowner AS wn_dataowner,
    wn.provider AS wn_provider

   FROM qgep.vw_cover co
     LEFT JOIN qgep.od_wastewater_structure ws ON ws.obj_id = co.fk_wastewater_structure
     LEFT JOIN qgep.od_manhole mh ON mh.obj_id = co.fk_wastewater_structure
     LEFT JOIN qgep.od_special_structure ss ON ss.obj_id = co.fk_wastewater_structure
     LEFT JOIN qgep.od_discharge_point dp ON dp.obj_id = co.fk_wastewater_structure
     LEFT JOIN qgep.od_infiltration_installation ii ON ii.obj_id = co.fk_wastewater_structure

     LEFT JOIN qgep.vw_wastewater_node wn ON wn.fk_wastewater_structure = ws.obj_id;

-- INSERT function

CREATE OR REPLACE FUNCTION qgep.vw_qgep_cover_INSERT()
  RETURNS trigger AS
$BODY$
BEGIN
  -- Manhole
  CASE
    WHEN NEW.ws_type = 'manhole' THEN
      INSERT INTO qgep.vw_manhole(
             dimension1
           , dimension2
           , depth
           , function
           , material
           , surface_inflow
           , accessibility
           , contract_section
    --       , detail_geometry_geometry
    --       , detail_geometry_3d_geometry
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
           , dataowner
           , provider
           , fk_owner
           , fk_operator
           )
           VALUES
           (
             NEW.dimension1
           , NEW.dimension2
           , NEW.depth
           , NEW.manhole_function
           , NEW.material
           , NEW.surface_inflow
           , NEW.accessibility
           , NEW.contract_section
    --       , NEW.detail_geometry_geometry
    --       , NEW.detail_geometry_3d_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.ws_identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.ws_remark
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
           , NEW.dataowner
           , NEW.provider
           , NEW.fk_owner
           , NEW.fk_operator
           ) RETURNING obj_id INTO NEW.ws_obj_id;

    -- Special Structure
    WHEN NEW.ws_type = 'special_structure' THEN
      INSERT INTO qgep.vw_special_structure(
             depth
           , emergency_spillway
           , function
           , stormwater_tank_arrangement
           , upper_elevation

           , accessibility
           , contract_section
    --       , detail_geometry_geometry
    --       , detail_geometry_3d_geometry
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
           , dataowner
           , provider
           , fk_owner
           , fk_operator
           )
           VALUES
           (
             NEW.depth
           , NEW.emergency_spillway
           , NEW.special_structure_function
           , NEW.stormwater_tank_arrangement
           , NEW.upper_elevation


           , NEW.accessibility
           , NEW.contract_section
    --       , NEW.detail_geometry_geometry
    --       , NEW.detail_geometry_3d_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.ws_identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.ws_remark
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
           , NEW.dataowner
           , NEW.provider
           , NEW.fk_owner
           , NEW.fk_operator
           ) RETURNING obj_id INTO NEW.ws_obj_id;

    -- Discharge Point
    WHEN NEW.ws_type = 'discharge_point' THEN
      INSERT INTO qgep.vw_discharge_point(
             depth
           , highwater_level
           , relevance
           , terrain_level
           , upper_elevation
           , waterlevel_hydraulic

           , accessibility
           , contract_section
    --       , detail_geometry_geometry
    --       , detail_geometry_3d_geometry
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
           , dataowner
           , provider
           , fk_owner
           , fk_operator
           )
           VALUES
           (
             NEW.depth
           , NEW.highwater_level
           , NEW.relevance
           , NEW.terrain_level
           , NEW.upper_elevation
           , NEW.waterlevel_hydraulic

           , NEW.accessibility
           , NEW.contract_section
    --       , NEW.detail_geometry_geometry
    --       , NEW.detail_geometry_3d_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.ws_identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.ws_remark
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
           , NEW.dataowner
           , NEW.provider
           , NEW.fk_owner
           , NEW.fk_operator
           ) RETURNING obj_id INTO NEW.ws_obj_id;

    -- Infiltration Installation
    WHEN NEW.ws_type = 'infiltration_installation' THEN
     RAISE NOTICE 'Wastewater structure type not known (%)', ws_type; -- ERROR
     -- TODO
    ELSE
     RAISE NOTICE 'Wastewater structure type not known (%)', ws_type; -- ERROR
  END CASE;

  IF NEW.identifier IS NULL OR NEW.identifier='' THEN
     NEW.identifier := NEW.ws_obj_id;
  END IF;

  INSERT INTO qgep.vw_wastewater_node(
      backflow_level
    , bottom_level
    , situation_geometry
    , identifier
    , remark
    , last_modification
    , dataowner
    , provider
    , fk_wastewater_structure
  )
  VALUES
  (
      NEW.backflow_level
    , NEW.bottom_level
    , NEW.situation_geometry
    , COALESCE(NULLIF(NEW.wn_identifier,''), NEW.identifier)
    , COALESCE(NULLIF(NEW.wn_remark,''), NEW.remark)
    , NOW()
    , COALESCE(NULLIF(NEW.wn_provider,''), NEW.provider) -- TODO will need to be switched to fk
    , COALESCE(NULLIF(NEW.wn_dataowner,''), NEW.dataowner) -- TODO will need to be switched to fk
    , NEW.ws_obj_id
  );

  INSERT INTO qgep.vw_cover(
      brand
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
    , dataowner
    , provider
    , fk_wastewater_structure
  )
  VALUES
  (
      NEW.brand
    , NEW.cover_shape
    , NEW.diameter
    , NEW.fastening
    , NEW.level
    , NEW.cover_material
    , NEW.positional_accuracy
    , NEW.situation_geometry
    , NEW.sludge_bucket
    , NEW.venting
    , NEW.identifier
    , NEW.remark
    , NEW.renovation_demand
    , NOW()
    , NEW.dataowner
    , NEW.provider
    , NEW.ws_obj_id
  ) RETURNING obj_id INTO NEW.obj_id;
  RETURN NEW;
END; $BODY$ LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS vw_qgep_cover_ON_INSERT ON qgep.vw_qgep_cover;

CREATE TRIGGER vw_qgep_cover_ON_INSERT INSTEAD OF INSERT ON qgep.vw_qgep_cover
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_qgep_cover_INSERT();

/**************************************************************
 * UPDATE
 *************************************************************/
CREATE OR REPLACE FUNCTION qgep.vw_qgep_cover_UPDATE()
  RETURNS trigger AS
$BODY$
DECLARE
  ws_obj_id character varying(16);
BEGIN
    IF NEW.identifier IS NULL OR NEW.identifier='' THEN
       NEW.identifier := NEW.ws_obj_id;
    END IF;

    UPDATE qgep.od_cover
      SET
        brand = NEW.brand,
        cover_shape = new.cover_shape,
        depth = new.depth,
        diameter = new.diameter,
        fastening = new.fastening,
        level = new.level,
        material = new.cover_material,
        positional_accuracy = new.positional_accuracy,
        situation_geometry = new.situation_geometry,
        sludge_bucket = new.sludge_bucket,
        venting = new.venting
    WHERE od_cover.obj_id::text = old.obj_id::text;

    UPDATE qgep.od_structure_part
      SET
        identifier = new.identifier,
        remark = new.remark,
        renovation_demand = new.renovation_demand,
        last_modification = new.last_modification,
        dataowner = new.dataowner,
        provider = new.provider
    WHERE od_structure_part.obj_id::text = old.obj_id::text;

    UPDATE qgep.od_wastewater_structure
      SET
        obj_id = NEW.ws_obj_id,
        identifier = NEW.ws_identifier,
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
     WHERE od_wastewater_structure.obj_id::text = old.ws_obj_id::text;

  IF OLD.ws_type <> NEW.ws_type THEN
    CASE
      WHEN OLD.ws_type = 'manhole' THEN DELETE FROM qgep.od_manhole WHERE obj_id = OLD.ws_obj_id;
      WHEN OLD.ws_type = 'special_structure' THEN DELETE FROM qgep.od_special_structure WHERE obj_id = OLD.ws_obj_id;
      WHEN OLD.ws_type = 'discharge_point' THEN DELETE FROM qgep.od_discharge_point WHERE obj_id = OLD.ws_obj_id;
      WHEN OLD.ws_type = 'infiltration_installation' THEN DELETE FROM qgep.infiltration_installation WHERE obj_id = OLD.ws_obj_id;
    END CASE;

    CASE
      WHEN NEW.ws_type = 'manhole' THEN INSERT INTO qgep.od_manhole (obj_id) VALUES(OLD.ws_obj_id);
      WHEN NEW.ws_type = 'special_structure' THEN INSERT INTO qgep.od_special_structure (obj_id) VALUES(OLD.ws_obj_id);
      WHEN NEW.ws_type = 'discharge_point' THEN INSERT INTO qgep.od_discharge_point (obj_id) VALUES(OLD.ws_obj_id);
      WHEN NEW.ws_type = 'infiltration_installation' THEN INSERT INTO qgep.infiltration_installation (obj_id) VALUES(OLD.ws_obj_id);
    END CASE;
  END IF;

  CASE
    WHEN NEW.ws_type = 'manhole' THEN
      UPDATE qgep.od_manhole
      SET
        depth = NEW.depth,
        dimension1 = NEW.dimension1,
        dimension2 = NEW.dimension2,
        function = NEW.manhole_function,
        material = NEW.material,
        surface_inflow = NEW.surface_inflow
      WHERE obj_id = OLD.ws_obj_id;

    WHEN NEW.ws_type = 'special_structure' THEN
      UPDATE qgep.od_special_structure
      SET
        bypass = NEW.bypass,
        depth = NEW.depth,
        emergency_spillway = NEW.emergency_spillway,
        function = NEW.special_structure_function,
        stormwater_tank_arrangement = NEW.stormwater_tank_arrangement,
        upper_elevation = NEW.upper_elevation
      WHERE obj_id = OLD.ws_obj_id;

    WHEN NEW.ws_type = 'discharge_point' THEN
      UPDATE qgep.od_discharge_point
      SET
        depth = NEW.depth,
        highwater_level = NEW.highwater_level,
        relevance = NEW.relevance,
        terrain_level = NEW.terrain_level,
        upper_elevation = NEW.upper_elevation,
        waterlevel_hydraulic = NEW.waterlevel_hydraulic
      WHERE obj_id = OLD.ws_obj_id;

    WHEN NEW.ws_type = 'infiltration_installation' THEN
    -- TODO
  END CASE;

  RETURN NEW;
END; $BODY$ LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS vw_qgep_cover_ON_UPDATE ON qgep.vw_qgep_cover;

CREATE TRIGGER vw_qgep_cover_ON_UPDATE INSTEAD OF UPDATE ON qgep.vw_qgep_cover
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_qgep_cover_UPDATE();

END TRANSACTION;
