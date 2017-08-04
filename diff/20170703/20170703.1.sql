-- 20170223_missing_relations_qgep_empty_schema
-- 23.2.2017 sb missing in datamodel qgep

ALTER TABLE qgep.od_river_bank ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_river_bank ADD CONSTRAINT rel_river_bank_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_river_bed ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_river_bed ADD CONSTRAINT rel_river_bed_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_water_course_segment ADD COLUMN fk_watercourse varchar (16);
ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT rel_water_course_segment_watercourse FOREIGN KEY (fk_watercourse) REFERENCES qgep.od_river(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_water_catchment ADD COLUMN fk_aquifier varchar (16);
ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT rel_water_catchment_aquifier FOREIGN KEY (fk_aquifier) REFERENCES qgep.od_aquifier(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_water_catchment ADD COLUMN fk_chute varchar (16);
ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT rel_water_catchment_chute FOREIGN KEY (fk_chute) REFERENCES qgep.od_surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_sector_water_body ADD COLUMN fk_chute varchar (16);
ALTER TABLE qgep.od_sector_water_body ADD CONSTRAINT rel_sector_water_body_chute FOREIGN KEY (fk_chute) REFERENCES qgep.od_surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_discharge_point ADD COLUMN fk_sector_water_body varchar (16);
ALTER TABLE qgep.od_discharge_point ADD CONSTRAINT rel_discharge_point_sector_water_body FOREIGN KEY (fk_sector_water_body) REFERENCES qgep.od_sector_water_body(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_infiltration_installation ADD COLUMN fk_aquifier varchar (16);
ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT rel_infiltration_installation_aquifier FOREIGN KEY (fk_aquifier) REFERENCES qgep.od_aquifier(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_wwtp_energy_use ADD CONSTRAINT rel_wwtp_energy_use_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_waste_water_treatment ADD CONSTRAINT rel_waste_water_treatment_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_sludge_treatment ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_sludge_treatment ADD CONSTRAINT rel_sludge_treatment_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_measuring_point_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_water_control_structure ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_water_control_structure ADD CONSTRAINT rel_water_control_structure_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_fish_pass ADD COLUMN fk_water_control_structure varchar (16);
ALTER TABLE qgep.od_fish_pass ADD CONSTRAINT rel_fish_pass_water_control_structure FOREIGN KEY (fk_water_control_structure) REFERENCES qgep.od_water_control_structure(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_bathing_area ADD COLUMN fk_chute varchar (16);
ALTER TABLE qgep.od_bathing_area ADD CONSTRAINT rel_bathing_area_chute FOREIGN KEY (fk_chute) REFERENCES qgep.od_surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_wastewater_node ADD COLUMN fk_hydr_geometry varchar (16);
ALTER TABLE qgep.od_wastewater_node ADD CONSTRAINT rel_wastewater_node_hydr_geometry FOREIGN KEY (fk_hydr_geometry) REFERENCES qgep.od_hydr_geometry(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_hq_relation ADD COLUMN fk_overflow_characteristic varchar (16);
ALTER TABLE qgep.od_hq_relation ADD CONSTRAINT rel_hq_relation_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_hazard_source ADD COLUMN fk_connection_object varchar (16);
ALTER TABLE qgep.od_hazard_source ADD CONSTRAINT rel_hazard_source_connection_object FOREIGN KEY (fk_connection_object) REFERENCES qgep.od_connection_object(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_accident ADD COLUMN fk_hazard_source varchar (16);
ALTER TABLE qgep.od_accident ADD CONSTRAINT rel_accident_hazard_source FOREIGN KEY (fk_hazard_source) REFERENCES qgep.od_hazard_source(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_substance ADD COLUMN fk_hazard_source varchar (16);
ALTER TABLE qgep.od_substance ADD CONSTRAINT rel_substance_hazard_source FOREIGN KEY (fk_hazard_source) REFERENCES qgep.od_hazard_source(obj_id) ON UPDATE CASCADE ON DELETE cascade;

-- catchment_text etc. fehlt in 03_qgep_db_dss_sql - code anpassen
--çç ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN fk_wastewater_structure varchar (16);
--ALTER TABLE qgep.txt_text ADD CONSTRAINT rel_wastewater_structure_text_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id) ON DELETE cascade;
--çç ALTER TABLE qgep.od_wastewater_structure_text ADD CONSTRAINT rel_wastewater_structure_text_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id) ON UPDATE CASCADE ON DELETE cascade;

--çç ALTER TABLE qgep.od_reach_text ADD COLUMN fk_reach varchar (16);
--ALTER TABLE qgep.txt_text ADD CONSTRAINT rel_reach_text_reach FOREIGN KEY (fk_reach) REFERENCES qgep.od_reach(obj_id) ON DELETE cascade;
--çç ALTER TABLE qgep.od_reach_text ADD CONSTRAINT rel_reach_text_reach FOREIGN KEY (fk_reach) REFERENCES qgep.od_reach(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_catchment_area_text ADD COLUMN fk_catchment varchar (16);
-- ALTER TABLE qgep.txt_text ADD CONSTRAINT rel_catchment_area_text_catchment_area FOREIGN KEY (fk_catchment_area) REFERENCES qgep.od_catchment_area(obj_id) ON DELETE cascade;
ALTER TABLE qgep.od_catchment_area_text ADD CONSTRAINT rel_catchment_area_text_catchment FOREIGN KEY (fk_catchment) REFERENCES qgep.od_catchment_area(obj_id) ON UPDATE CASCADE ON DELETE cascade;

--çç ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN fk_wastewater_structure varchar (16);
--ALTER TABLE qgep.txt_symbol ADD CONSTRAINT rel_wastewater_structure_symbol_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id) ON DELETE cascade;
--çç ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT rel_wastewater_structure_symbol_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN fk_catchment_area varchar (16);
ALTER TABLE qgep.od_surface_runoff_parameters ADD CONSTRAINT rel_surface_runoff_parameters_catchment_area FOREIGN KEY (fk_catchment_area) REFERENCES qgep.od_catchment_area(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_measuring_point_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_measuring_device ADD COLUMN fk_measuring_point varchar (16);
ALTER TABLE qgep.od_measuring_device ADD CONSTRAINT rel_measuring_device_measuring_point FOREIGN KEY (fk_measuring_point) REFERENCES qgep.od_measuring_point(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_measurement_series ADD COLUMN fk_measuring_point varchar (16);
ALTER TABLE qgep.od_measurement_series ADD CONSTRAINT rel_measurement_series_measuring_point FOREIGN KEY (fk_measuring_point) REFERENCES qgep.od_measuring_point(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_measurement_result ADD COLUMN fk_measuring_device varchar (16);
ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT rel_measurement_result_measuring_device FOREIGN KEY (fk_measuring_device) REFERENCES qgep.od_measuring_device(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_measurement_result ADD COLUMN fk_measurement_series varchar (16);
ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT rel_measurement_result_measurement_series FOREIGN KEY (fk_measurement_series) REFERENCES qgep.od_measurement_series(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep.od_overflow ADD COLUMN fk_overflow_characteristic varchar (16);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_overflow ADD COLUMN fk_control_center varchar (16);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_control_center FOREIGN KEY (fk_control_center) REFERENCES qgep.od_control_center(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_control_center varchar (16);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_throttle_shut_off_unit_control_center FOREIGN KEY (fk_control_center) REFERENCES qgep.od_control_center(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_overflow varchar (16);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_throttle_shut_off_unit_overflow FOREIGN KEY (fk_overflow) REFERENCES qgep.od_overflow(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN fk_overflow_characteristic varchar (16);
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT rel_hydraulic_characteristic_data_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_backflow_prevention ADD COLUMN fk_throttle_shut_off_unit varchar (16);
ALTER TABLE qgep.od_backflow_prevention ADD CONSTRAINT rel_backflow_prevention_throttle_shut_off_unit FOREIGN KEY (fk_throttle_shut_off_unit) REFERENCES qgep.od_throttle_shut_off_unit(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_backflow_prevention ADD COLUMN fk_pump varchar (16);
ALTER TABLE qgep.od_backflow_prevention ADD CONSTRAINT rel_backflow_prevention_pump FOREIGN KEY (fk_pump) REFERENCES qgep.od_pump(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_tank_emptying ADD COLUMN fk_throttle_shut_off_unit varchar (16);
ALTER TABLE qgep.od_tank_emptying ADD CONSTRAINT rel_tank_emptying_throttle_shut_off_unit FOREIGN KEY (fk_throttle_shut_off_unit) REFERENCES qgep.od_throttle_shut_off_unit(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_tank_emptying ADD COLUMN fk_overflow varchar (16);
ALTER TABLE qgep.od_tank_emptying ADD CONSTRAINT rel_tank_emptying_overflow FOREIGN KEY (fk_overflow) REFERENCES qgep.od_pump(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN fk_hydr_geometry varchar (16);
ALTER TABLE qgep.od_hydr_geom_relation ADD CONSTRAINT rel_hydr_geom_relation_hydr_geometry FOREIGN KEY (fk_hydr_geometry) REFERENCES qgep.od_hydr_geometry(obj_id) ON UPDATE CASCADE ON DELETE cascade;
