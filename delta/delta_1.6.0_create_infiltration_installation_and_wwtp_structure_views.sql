-- View: qgep_od.vw_infiltration_installation

DROP VIEW IF EXISTS qgep_od.vw_infiltration_installation;

CREATE OR REPLACE VIEW qgep_od.vw_infiltration_installation
 AS
 SELECT infiltration_installation.obj_id,
    infiltration_installation.absorption_capacity,
    infiltration_installation.defects,
    infiltration_installation.dimension1,
    infiltration_installation.dimension2,
    infiltration_installation.distance_to_aquifer,
    infiltration_installation.effective_area,
    infiltration_installation.emergency_spillway,
    infiltration_installation.fk_aquifier,
    infiltration_installation.kind,
    infiltration_installation.labeling,
    infiltration_installation.seepage_utilization,
    infiltration_installation.upper_elevation,
    infiltration_installation.vehicle_access,
    infiltration_installation.watertightness,
    wastewater_structure._bottom_label,
    wastewater_structure._cover_label,
    wastewater_structure._depth,
    wastewater_structure._function_hierarchic,
    wastewater_structure._input_label,
    wastewater_structure._label,
    wastewater_structure._output_label,
    wastewater_structure._usage_current,
    wastewater_structure.accessibility,
    wastewater_structure.contract_section,
    wastewater_structure.detail_geometry_geometry,
    wastewater_structure.financing,
    wastewater_structure.fk_dataowner,
    wastewater_structure.fk_main_cover,
    wastewater_structure.fk_main_wastewater_node,
    wastewater_structure.fk_operator,
    wastewater_structure.fk_owner,
    wastewater_structure.fk_provider,
    wastewater_structure.gross_costs,
    wastewater_structure.identifier,
    wastewater_structure.inspection_interval,
    wastewater_structure.last_modification,
    wastewater_structure.location_name,
    wastewater_structure.records,
    wastewater_structure.remark,
    wastewater_structure.renovation_necessity,
    wastewater_structure.replacement_value,
    wastewater_structure.rv_base_year,
    wastewater_structure.rv_construction_type,
    wastewater_structure.status,
    wastewater_structure.structure_condition,
    wastewater_structure.subsidies,
    wastewater_structure.year_of_construction,
    wastewater_structure.year_of_replacement
   FROM qgep_od.infiltration_installation
     LEFT JOIN qgep_od.wastewater_structure ON wastewater_structure.obj_id::text = infiltration_installation.obj_id::text;

-- FUNCTION: qgep_od.ft_vw_infiltration_installation_delete()

CREATE OR REPLACE FUNCTION qgep_od.ft_vw_infiltration_installation_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  DELETE FROM qgep_od.infiltration_installation WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.wastewater_structure WHERE obj_id = OLD.obj_id;
RETURN NULL;
END;
$BODY$;

CREATE TRIGGER tr_vw_infiltration_installation_on_delete
    INSTEAD OF DELETE
    ON qgep_od.vw_infiltration_installation
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_infiltration_installation_delete();

-- FUNCTION: qgep_od.ft_vw_infiltration_installation_insert()

CREATE OR REPLACE FUNCTION qgep_od.ft_vw_infiltration_installation_insert()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
INSERT INTO qgep_od.wastewater_structure (
        obj_id
      , _bottom_label
      , _cover_label
      , _depth
      , _function_hierarchic
      , _input_label
      , _label
      , _output_label
      , _usage_current
      , accessibility
      , contract_section
      , detail_geometry_geometry
      , financing
      , fk_dataowner
      , fk_main_cover
      , fk_main_wastewater_node
      , fk_operator
      , fk_owner
      , fk_provider
      , gross_costs
      , identifier
      , inspection_interval
      , last_modification
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
    ) VALUES (
        COALESCE( NEW.obj_id, qgep_sys.generate_oid('qgep_od'::text, 'wastewater_structure'::text) )
      , NEW._bottom_label
      , NEW._cover_label
      , NEW._depth
      , NEW._function_hierarchic
      , NEW._input_label
      , NEW._label
      , NEW._output_label
      , NEW._usage_current
      , NEW.accessibility
      , NEW.contract_section
      , NEW.detail_geometry_geometry
      , NEW.financing
      , NEW.fk_dataowner
      , NEW.fk_main_cover
      , NEW.fk_main_wastewater_node
      , NEW.fk_operator
      , NEW.fk_owner
      , NEW.fk_provider
      , NEW.gross_costs
      , NEW.identifier
      , NEW.inspection_interval
      , NEW.last_modification
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
    ) RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.infiltration_installation (
        obj_id
      , absorption_capacity
      , defects
      , dimension1
      , dimension2
      , distance_to_aquifer
      , effective_area
      , emergency_spillway
      , fk_aquifier
      , kind
      , labeling
      , seepage_utilization
      , upper_elevation
      , vehicle_access
      , watertightness
    ) VALUES (
        NEW.obj_id
      , NEW.absorption_capacity
      , NEW.defects
      , NEW.dimension1
      , NEW.dimension2
      , NEW.distance_to_aquifer
      , NEW.effective_area
      , NEW.emergency_spillway
      , NEW.fk_aquifier
      , NEW.kind
      , NEW.labeling
      , NEW.seepage_utilization
      , NEW.upper_elevation
      , NEW.vehicle_access
      , NEW.watertightness
    );

RETURN NEW;
END;
$BODY$;

CREATE TRIGGER tr_vw_infiltration_installation_on_insert
    INSTEAD OF INSERT
    ON qgep_od.vw_infiltration_installation
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_infiltration_installation_insert();

-- FUNCTION: qgep_od.ft_vw_infiltration_installation_update()

CREATE OR REPLACE FUNCTION qgep_od.ft_vw_infiltration_installation_update()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
UPDATE qgep_od.wastewater_structure SET
      _bottom_label = NEW._bottom_label
      , _cover_label = NEW._cover_label
      , _depth = NEW._depth
      , _function_hierarchic = NEW._function_hierarchic
      , _input_label = NEW._input_label
      , _label = NEW._label
      , _output_label = NEW._output_label
      , _usage_current = NEW._usage_current
      , accessibility = NEW.accessibility
      , contract_section = NEW.contract_section
      , detail_geometry_geometry = NEW.detail_geometry_geometry
      , financing = NEW.financing
      , fk_dataowner = NEW.fk_dataowner
      , fk_main_cover = NEW.fk_main_cover
      , fk_main_wastewater_node = NEW.fk_main_wastewater_node
      , fk_operator = NEW.fk_operator
      , fk_owner = NEW.fk_owner
      , fk_provider = NEW.fk_provider
      , gross_costs = NEW.gross_costs
      , identifier = NEW.identifier
      , inspection_interval = NEW.inspection_interval
      , last_modification = NEW.last_modification
      , location_name = NEW.location_name
      , records = NEW.records
      , remark = NEW.remark
      , renovation_necessity = NEW.renovation_necessity
      , replacement_value = NEW.replacement_value
      , rv_base_year = NEW.rv_base_year
      , rv_construction_type = NEW.rv_construction_type
      , status = NEW.status
      , structure_condition = NEW.structure_condition
      , subsidies = NEW.subsidies
      , year_of_construction = NEW.year_of_construction
      , year_of_replacement = NEW.year_of_replacement
    WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.infiltration_installation SET
      obj_id = NEW.obj_id
      , absorption_capacity = NEW.absorption_capacity
      , defects = NEW.defects
      , dimension1 = NEW.dimension1
      , dimension2 = NEW.dimension2
      , distance_to_aquifer = NEW.distance_to_aquifer
      , effective_area = NEW.effective_area
      , emergency_spillway = NEW.emergency_spillway
      , fk_aquifier = NEW.fk_aquifier
      , kind = NEW.kind
      , labeling = NEW.labeling
      , seepage_utilization = NEW.seepage_utilization
      , upper_elevation = NEW.upper_elevation
      , vehicle_access = NEW.vehicle_access
      , watertightness = NEW.watertightness
    WHERE obj_id = OLD.obj_id;
RETURN NEW;
END;
$BODY$;

CREATE TRIGGER tr_vw_infiltration_installation_on_update
    INSTEAD OF UPDATE
    ON qgep_od.vw_infiltration_installation
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_infiltration_installation_update();


-- View: qgep_od.vw_wwtp_structure

DROP VIEW IF EXISTS qgep_od.vw_wwtp_structure;

CREATE OR REPLACE VIEW qgep_od.vw_wwtp_structure
 AS
 SELECT wwtp_structure.obj_id,
    wwtp_structure.kind,
    wastewater_structure._bottom_label,
    wastewater_structure._cover_label,
    wastewater_structure._depth,
    wastewater_structure._function_hierarchic,
    wastewater_structure._input_label,
    wastewater_structure._label,
    wastewater_structure._output_label,
    wastewater_structure._usage_current,
    wastewater_structure.accessibility,
    wastewater_structure.contract_section,
    wastewater_structure.detail_geometry_geometry,
    wastewater_structure.financing,
    wastewater_structure.fk_dataowner,
    wastewater_structure.fk_main_cover,
    wastewater_structure.fk_main_wastewater_node,
    wastewater_structure.fk_operator,
    wastewater_structure.fk_owner,
    wastewater_structure.fk_provider,
    wastewater_structure.gross_costs,
    wastewater_structure.identifier,
    wastewater_structure.inspection_interval,
    wastewater_structure.last_modification,
    wastewater_structure.location_name,
    wastewater_structure.records,
    wastewater_structure.remark,
    wastewater_structure.renovation_necessity,
    wastewater_structure.replacement_value,
    wastewater_structure.rv_base_year,
    wastewater_structure.rv_construction_type,
    wastewater_structure.status,
    wastewater_structure.structure_condition,
    wastewater_structure.subsidies,
    wastewater_structure.year_of_construction,
    wastewater_structure.year_of_replacement
   FROM qgep_od.wwtp_structure
     LEFT JOIN qgep_od.wastewater_structure ON wastewater_structure.obj_id::text = wwtp_structure.obj_id::text;

-- FUNCTION: qgep_od.ft_vw_wwtp_structure_delete()

CREATE OR REPLACE FUNCTION qgep_od.ft_vw_wwtp_structure_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
  DELETE FROM qgep_od.wwtp_structure WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.wastewater_structure WHERE obj_id = OLD.obj_id;
RETURN NULL;
END;
$BODY$;

CREATE TRIGGER tr_vw_wwtp_structure_on_delete
    INSTEAD OF DELETE
    ON qgep_od.vw_wwtp_structure
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_wwtp_structure_delete();

-- FUNCTION: qgep_od.ft_vw_wwtp_structure_insert()

CREATE OR REPLACE FUNCTION qgep_od.ft_vw_wwtp_structure_insert()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
INSERT INTO qgep_od.wastewater_structure (
        obj_id
      , _bottom_label
      , _cover_label
      , _depth
      , _function_hierarchic
      , _input_label
      , _label
      , _output_label
      , _usage_current
      , accessibility
      , contract_section
      , detail_geometry_geometry
      , financing
      , fk_dataowner
      , fk_main_cover
      , fk_main_wastewater_node
      , fk_operator
      , fk_owner
      , fk_provider
      , gross_costs
      , identifier
      , inspection_interval
      , last_modification
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
    ) VALUES (
        COALESCE( NEW.obj_id, qgep_sys.generate_oid('qgep_od'::text, 'wastewater_structure'::text) )
      , NEW._bottom_label
      , NEW._cover_label
      , NEW._depth
      , NEW._function_hierarchic
      , NEW._input_label
      , NEW._label
      , NEW._output_label
      , NEW._usage_current
      , NEW.accessibility
      , NEW.contract_section
      , NEW.detail_geometry_geometry
      , NEW.financing
      , NEW.fk_dataowner
      , NEW.fk_main_cover
      , NEW.fk_main_wastewater_node
      , NEW.fk_operator
      , NEW.fk_owner
      , NEW.fk_provider
      , NEW.gross_costs
      , NEW.identifier
      , NEW.inspection_interval
      , NEW.last_modification
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
    ) RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.wwtp_structure (
        obj_id
      , kind
    ) VALUES (
        NEW.obj_id
      , NEW.kind
    );

RETURN NEW;
END;
$BODY$;

CREATE TRIGGER tr_vw_wwtp_structure_on_insert
    INSTEAD OF INSERT
    ON qgep_od.vw_wwtp_structure
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_wwtp_structure_insert();

-- FUNCTION: qgep_od.ft_vw_wwtp_structure_update()

CREATE OR REPLACE FUNCTION qgep_od.ft_vw_wwtp_structure_update()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
UPDATE qgep_od.wastewater_structure SET
      _bottom_label = NEW._bottom_label
      , _cover_label = NEW._cover_label
      , _depth = NEW._depth
      , _function_hierarchic = NEW._function_hierarchic
      , _input_label = NEW._input_label
      , _label = NEW._label
      , _output_label = NEW._output_label
      , _usage_current = NEW._usage_current
      , accessibility = NEW.accessibility
      , contract_section = NEW.contract_section
      , detail_geometry_geometry = NEW.detail_geometry_geometry
      , financing = NEW.financing
      , fk_dataowner = NEW.fk_dataowner
      , fk_main_cover = NEW.fk_main_cover
      , fk_main_wastewater_node = NEW.fk_main_wastewater_node
      , fk_operator = NEW.fk_operator
      , fk_owner = NEW.fk_owner
      , fk_provider = NEW.fk_provider
      , gross_costs = NEW.gross_costs
      , identifier = NEW.identifier
      , inspection_interval = NEW.inspection_interval
      , last_modification = NEW.last_modification
      , location_name = NEW.location_name
      , records = NEW.records
      , remark = NEW.remark
      , renovation_necessity = NEW.renovation_necessity
      , replacement_value = NEW.replacement_value
      , rv_base_year = NEW.rv_base_year
      , rv_construction_type = NEW.rv_construction_type
      , status = NEW.status
      , structure_condition = NEW.structure_condition
      , subsidies = NEW.subsidies
      , year_of_construction = NEW.year_of_construction
      , year_of_replacement = NEW.year_of_replacement
    WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.wwtp_structure SET
      obj_id = NEW.obj_id
      , kind = NEW.kind
    WHERE obj_id = OLD.obj_id;
RETURN NEW;
END;
$BODY$;

CREATE TRIGGER tr_vw_wwtp_structure_on_update
    INSTEAD OF UPDATE
    ON qgep_od.vw_wwtp_structure
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_wwtp_structure_update();
