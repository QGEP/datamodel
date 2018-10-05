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
           , NEW.ss_function
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
    , NEW.wn_backflow_level
    , NEW.wn_bottom_level
    , ST_GeometryN( NEW.situation_geometry, 1 )
    , COALESCE(NULLIF(NEW.wn_identifier,''), NEW.identifier)
    , NEW.wn_remark
    , NOW()
    , COALESCE(NULLIF(NEW.wn_fk_dataowner,''), NEW.fk_dataowner)
    , COALESCE(NULLIF(NEW.wn_fk_provider,''), NEW.fk_provider)
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
