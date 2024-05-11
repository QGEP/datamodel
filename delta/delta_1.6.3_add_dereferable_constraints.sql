--- Add additional DEREFERABLE constraints

ALTER TABLE qgep_od.re_maintenance_event_wastewater_structure ALTER CONSTRAINT rel_maintenance_event_wastewater_structure_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.re_maintenance_event_wastewater_structure ALTER CONSTRAINT rel_maintenance_event_wastewater_structure_maintenance_event DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.txt_symbol ALTER CONSTRAINT rel_symbol_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.txt_text ALTER CONSTRAINT rel_text_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.txt_text ALTER CONSTRAINT rel_text_catchment_area  DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.txt_text ALTER CONSTRAINT rel_text_reach DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.river ALTER CONSTRAINT oorel_od_river_surface_water_bodies DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.lake ALTER CONSTRAINT oorel_od_lake_surface_water_bodies DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.water_course_segment ALTER CONSTRAINT rel_water_course_segment_watercourse DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.water_catchment ALTER CONSTRAINT rel_water_catchment_aquifier DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.water_catchment ALTER CONSTRAINT rel_water_catchment_surface_water_bodies DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.river_bank ALTER CONSTRAINT rel_river_bank_water_course_segment DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.river_bed ALTER CONSTRAINT rel_river_bed_water_course_segment DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.sector_water_body ALTER CONSTRAINT rel_sector_water_body_surface_water_bodies DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.cooperative ALTER CONSTRAINT oorel_od_cooperative_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.canton ALTER CONSTRAINT oorel_od_canton_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.waste_water_association ALTER CONSTRAINT oorel_od_waste_water_association_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.municipality ALTER CONSTRAINT oorel_od_municipality_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.administrative_office ALTER CONSTRAINT oorel_od_administrative_office_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.waste_water_treatment_plant ALTER CONSTRAINT oorel_od_waste_water_treatment_plant_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.private ALTER CONSTRAINT oorel_od_private_organisation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wastewater_structure ALTER CONSTRAINT rel_wastewater_structure_owner DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wastewater_structure ALTER CONSTRAINT rel_wastewater_structure_operator DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.channel ALTER CONSTRAINT oorel_od_channel_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.manhole ALTER CONSTRAINT oorel_od_manhole_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.discharge_point ALTER CONSTRAINT oorel_od_discharge_point_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.discharge_point ALTER CONSTRAINT rel_discharge_point_sector_water_body DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.special_structure ALTER CONSTRAINT oorel_od_special_structure_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.infiltration_installation ALTER CONSTRAINT oorel_od_infiltration_installation_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.infiltration_installation ALTER CONSTRAINT rel_infiltration_installation_aquifier DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wwtp_structure ALTER CONSTRAINT oorel_od_wwtp_structure_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.maintenance_event ALTER CONSTRAINT rel_maintenance_event_operating_company DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.planning_zone ALTER CONSTRAINT oorel_od_planning_zone_zone DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.infiltration_zone ALTER CONSTRAINT oorel_od_infiltration_zone_zone DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.drainage_system ALTER CONSTRAINT oorel_od_drainage_system_zone DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.water_body_protection_sector ALTER CONSTRAINT oorel_od_water_body_protection_sector_zone DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.ground_water_protection_perimeter ALTER CONSTRAINT oorel_od_ground_water_protection_perimeter_zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE qgep_od.groundwater_protection_zone ALTER CONSTRAINT oorel_od_groundwater_protection_zone_zone DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wwtp_energy_use ALTER CONSTRAINT rel_wwtp_energy_use_waste_water_treatment_plant DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.waste_water_treatment ALTER CONSTRAINT rel_waste_water_treatment_waste_water_treatment_plant DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.sludge_treatment ALTER CONSTRAINT rel_sludge_treatment_waste_water_treatment_plant DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.water_control_structure ALTER CONSTRAINT rel_water_control_structure_water_course_segment DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.ford ALTER CONSTRAINT oorel_od_ford_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.chute ALTER CONSTRAINT oorel_od_chute_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.passage ALTER CONSTRAINT oorel_od_passage_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.blocking_debris ALTER CONSTRAINT oorel_od_blocking_debris_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.dam ALTER CONSTRAINT oorel_od_dam_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.rock_ramp ALTER CONSTRAINT oorel_od_rock_ramp_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.fish_pass ALTER CONSTRAINT rel_fish_pass_water_control_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.bathing_area ALTER CONSTRAINT rel_bathing_area_surface_water_bodies DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wastewater_networkelement ALTER CONSTRAINT rel_wastewater_networkelement_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.reach_point ALTER CONSTRAINT rel_reach_point_wastewater_networkelement DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wastewater_node ALTER CONSTRAINT oorel_od_wastewater_node_wastewater_networkelement DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.wastewater_node ALTER CONSTRAINT rel_wastewater_node_hydr_geometry DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.reach ALTER CONSTRAINT oorel_od_reach_wastewater_networkelement DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.reach ALTER CONSTRAINT rel_reach_reach_point_from DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.reach ALTER CONSTRAINT rel_reach_reach_point_to DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.reach ALTER CONSTRAINT rel_reach_pipe_profile DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.profile_geometry ALTER CONSTRAINT rel_profile_geometry_pipe_profile DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.hydr_geom_relation ALTER CONSTRAINT rel_hydr_geom_relation_hydr_geometry DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.mechanical_pretreatment ALTER CONSTRAINT rel_mechanical_pretreatment_infiltration_installation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.mechanical_pretreatment ALTER CONSTRAINT rel_mechanical_pretreatment_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.retention_body ALTER CONSTRAINT rel_retention_body_infiltration_installation DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.hq_relation ALTER CONSTRAINT rel_hq_relation_overflow_char DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.structure_part ALTER CONSTRAINT rel_structure_part_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.dryweather_downspout ALTER CONSTRAINT oorel_od_dryweather_downspout_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.access_aid ALTER CONSTRAINT oorel_od_access_aid_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.dryweather_flume ALTER CONSTRAINT oorel_od_dryweather_flume_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.cover ALTER CONSTRAINT oorel_od_cover_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.electric_equipment ALTER CONSTRAINT oorel_od_electric_equipment_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.electromechanical_equipment ALTER CONSTRAINT oorel_od_electromechanical_equipment_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.benching ALTER CONSTRAINT oorel_od_benching_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.connection_object ALTER CONSTRAINT rel_connection_object_wastewater_networkelement DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.connection_object ALTER CONSTRAINT rel_connection_object_owner DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.connection_object ALTER CONSTRAINT rel_connection_object_operator DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.building ALTER CONSTRAINT oorel_od_building_connection_object DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.reservoir ALTER CONSTRAINT oorel_od_reservoir_connection_object DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.individual_surface ALTER CONSTRAINT oorel_od_individual_surface_connection_object DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.fountain ALTER CONSTRAINT oorel_od_fountain_connection_object DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.hazard_source ALTER CONSTRAINT rel_hazard_source_connection_object DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.hazard_source ALTER CONSTRAINT rel_hazard_source_owner DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.accident ALTER CONSTRAINT rel_accident_hazard_source DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.substance ALTER CONSTRAINT rel_substance_hazard_source DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.catchment_area ALTER CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_current DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.catchment_area ALTER CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_planned DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.catchment_area ALTER CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_planned DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.catchment_area ALTER CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_current DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.surface_runoff_parameters ALTER CONSTRAINT rel_surface_runoff_parameters_catchment_area DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measuring_point ALTER CONSTRAINT rel_measuring_point_operator DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measuring_point ALTER CONSTRAINT rel_measuring_point_waste_water_treatment_plant DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measuring_point ALTER CONSTRAINT rel_measuring_point_wastewater_structure DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measuring_point ALTER CONSTRAINT rel_measuring_point_water_course_segment DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measuring_device ALTER CONSTRAINT rel_measuring_device_measuring_point DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measurement_series ALTER CONSTRAINT rel_measurement_series_measuring_point DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measurement_result ALTER CONSTRAINT rel_measurement_result_measuring_device DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.measurement_result ALTER CONSTRAINT rel_measurement_result_measurement_series DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.overflow ALTER CONSTRAINT rel_overflow_wastewater_node DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.overflow ALTER CONSTRAINT rel_overflow_overflow_to DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.overflow ALTER CONSTRAINT rel_overflow_overflow_char DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.overflow ALTER CONSTRAINT rel_overflow_control_center DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.throttle_shut_off_unit ALTER CONSTRAINT rel_throttle_shut_off_unit_wastewater_node DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.throttle_shut_off_unit ALTER CONSTRAINT rel_throttle_shut_off_unit_control_center DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.throttle_shut_off_unit ALTER CONSTRAINT rel_throttle_shut_off_unit_overflow DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.prank_weir ALTER CONSTRAINT oorel_od_prank_weir_overflow DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.pump ALTER CONSTRAINT oorel_od_pump_overflow DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.leapingweir ALTER CONSTRAINT oorel_od_leapingweir_overflow DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.hydraulic_char_data ALTER CONSTRAINT rel_hydraulic_char_data_wastewater_node DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.hydraulic_char_data ALTER CONSTRAINT rel_hydraulic_char_data_overflow_char DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.backflow_prevention ALTER CONSTRAINT oorel_od_backflow_prevention_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.backflow_prevention ALTER CONSTRAINT rel_backflow_prevention_throttle_shut_off_unit DEFERRABLE INITIALLY DEFERRED;

16);
ALTER TABLE qgep_od.backflow_prevention ALTER CONSTRAINT rel_backflow_prevention_pump DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.solids_retention ALTER CONSTRAINT oorel_od_solids_retention_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.tank_cleaning ALTER CONSTRAINT oorel_od_tank_cleaning_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.tank_emptying ALTER CONSTRAINT oorel_od_tank_emptying_structure_part DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.tank_emptying ALTER CONSTRAINT rel_tank_emptying_throttle_shut_off_unit DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.tank_emptying ALTER CONSTRAINT rel_tank_emptying_overflow DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.param_ca_general ALTER CONSTRAINT oorel_od_param_ca_general_surface_runoff_parameters DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.param_ca_mouse1 ALTER CONSTRAINT oorel_od_param_ca_mouse1_surface_runoff_parameters DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.organisation ALTER CONSTRAINT rel_od_organisation_fk_dataowner DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE qgep_od.organisation ALTER CONSTRAINT rel_od_organisation_fk_dataprovider DEFERRABLE INITIALLY DEFERRED;
