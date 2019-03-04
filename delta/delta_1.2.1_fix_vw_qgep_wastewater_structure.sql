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
      ELSE -- do nothing
    END CASE;

    CASE
      WHEN NEW.ws_type = 'manhole' THEN INSERT INTO qgep_od.manhole (obj_id) VALUES(OLD.obj_id);
      WHEN NEW.ws_type = 'special_structure' THEN INSERT INTO qgep_od.special_structure (obj_id) VALUES(OLD.obj_id);
      WHEN NEW.ws_type = 'discharge_point' THEN INSERT INTO qgep_od.discharge_point (obj_id) VALUES(OLD.obj_id);
      WHEN NEW.ws_type = 'infiltration_installation' THEN INSERT INTO qgep_od.infiltration_installation (obj_id) VALUES(OLD.obj_id);
      ELSE -- do nothing
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
    ELSE -- do nothing
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
    SET situation_geometry = ST_SetSRID( ST_MakePoint(
    ST_X(ST_TRANSLATE(ST_MakePoint(ST_X(WN.situation_geometry), ST_Y(WN.situation_geometry)), dx, dy )),
    ST_Y(ST_TRANSLATE(ST_MakePoint(ST_X(WN.situation_geometry), ST_Y(WN.situation_geometry)), dx, dy )),
    ST_Z(WN.situation_geometry)), %(SRID)s )
    WHERE obj_id IN
    (
      SELECT obj_id FROM qgep_od.wastewater_networkelement
      WHERE fk_wastewater_structure = NEW.obj_id
    );

    -- Move covers
    UPDATE qgep_od.cover CO
    SET situation_geometry = ST_SetSRID( ST_MakePoint(
    ST_X(ST_TRANSLATE(ST_MakePoint(ST_X(CO.situation_geometry), ST_Y(CO.situation_geometry)), dx, dy )),
    ST_Y(ST_TRANSLATE(ST_MakePoint(ST_X(CO.situation_geometry), ST_Y(CO.situation_geometry)), dx, dy )),
    ST_Z(CO.situation_geometry)), %(SRID)s )
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
        ST_SetSRID( ST_MakePoint(
            ST_X(ST_TRANSLATE(ST_MakePoint(ST_X(ST_PointN(RE.progression_geometry, 1)), ST_Y(ST_PointN(RE.progression_geometry, 1))), dx, dy )),
            ST_Y(ST_TRANSLATE(ST_MakePoint(ST_X(ST_PointN(RE.progression_geometry, 1)), ST_Y(ST_PointN(RE.progression_geometry, 1))), dx, dy )),
            ST_Z(ST_PointN(RE.progression_geometry, 1))), %(SRID)s )
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
        ST_SetSRID( ST_MakePoint(
            ST_X(ST_TRANSLATE(ST_MakePoint(ST_X(ST_EndPoint(RE.progression_geometry)), ST_Y(ST_EndPoint(RE.progression_geometry))), dx, dy )),
            ST_Y(ST_TRANSLATE(ST_MakePoint(ST_X(ST_EndPoint(RE.progression_geometry)), ST_Y(ST_EndPoint(RE.progression_geometry))), dx, dy )),
            ST_Z(ST_PointN(RE.progression_geometry, 1))), %(SRID)s )
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