#!/usr/bin/env python3
#
# -- View: vw_qgep_wastewater_structure

import os
import psycopg2
from pirogue.utils import select_columns, insert_command, update_command

pg_service = os.getenv('PGSERVICE')
SRID = os.getenv('SRID')
assert pg_service

variables = {'SRID': int(SRID)}

conn = psycopg2.connect("service={0}".format(pg_service))
cursor = conn.cursor()

view_sql = """
DROP VIEW IF EXISTS qgep_od.vw_qgep_reach;

CREATE OR REPLACE VIEW qgep_od.vw_qgep_reach AS

SELECT 
    re.obj_id,
    re.clear_height,
    re.material,
    ch.usage_current AS ch_usage_current,
    ch.function_hierarchic AS ch_function_hierarchic,
    ws.status AS ws_status,
    ws.fk_owner AS ws_fk_owner,
    ch.function_hydraulic AS ch_function_hydraulic,
    CASE 
      WHEN pp.height_width_ratio IS NOT NULL THEN round(re.clear_height::numeric * pp.height_width_ratio)::smallint 
      ELSE clear_height 
    END AS width,
    CASE 
      WHEN rp_from.level > 0 AND rp_to.level > 0 THEN round((rp_from.level - rp_to.level)/re.length_effective*1000,1) 
      ELSE NULL 
    END AS _slope_per_mill,
    {re_cols},
    {ne_cols},
    {ch_cols},
    {ws_cols},
    {rp_from_cols},
    {rp_to_cols}
  FROM qgep_od.reach re
     LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = re.obj_id
     LEFT JOIN qgep_od.reach_point rp_from ON rp_from.obj_id = re.fk_reach_point_from
     LEFT JOIN qgep_od.reach_point rp_to ON rp_to.obj_id = re.fk_reach_point_to
     LEFT JOIN qgep_od.wastewater_structure ws ON ne.fk_wastewater_structure = ws.obj_id
     LEFT JOIN qgep_od.channel ch ON ch.obj_id = ws.obj_id
     LEFT JOIN qgep_od.pipe_profile pp ON re.fk_pipe_profile = pp.obj_id;
""".format(re_cols=select_columns(pg_cur=cursor,
                                  table_schema='qgep_od',
                                  table_name='reach',
                                  table_alias='re',
                                  remove_pkey=True,
                                  indent=4,
                                  skip_columns=['clear_height', 'material',
                                                'fk_reach_point_from', 'fk_reach_point_to']),
           ne_cols=select_columns(pg_cur=cursor,
                                  table_schema='qgep_od',
                                  table_name='wastewater_networkelement',
                                  table_alias='ne',
                                  remove_pkey=True,
                                  indent=4),
           ch_cols=select_columns(pg_cur=cursor,
                                  table_schema='qgep_od',
                                  table_name='channel',
                                  table_alias='ch',
                                  prefix='ch_',
                                  remove_pkey=True,
                                  indent=4,
                                  skip_columns=['usage_current', 'function_hierarchic', 'function_hydraulic']),
           ws_cols=select_columns(pg_cur=cursor,
                                  table_schema='qgep_od',
                                  table_name='wastewater_structure',
                                  table_alias='ws',
                                  prefix='ws_',
                                  remove_pkey=False,
                                  indent=4,
                                  skip_columns=['detail_geometry_geometry', 'status', 'fk_owner',
                                                'fk_dataowner', 'fk_provider', '_usage_current',
                                                '_function_hierarchic', '_label', '_depth']),
           rp_from_cols=select_columns(pg_cur=cursor,
                                       table_schema='qgep_od',
                                       table_name='reach_point',
                                       table_alias='rp_from',
                                       prefix='rp_from_',
                                       remove_pkey=False,
                                       indent=4,
                                       skip_columns=['situation_geometry']),
           rp_to_cols=select_columns(pg_cur=cursor,
                                     table_schema='qgep_od',
                                     table_name='reach_point',
                                     table_alias='rp_to',
                                     prefix='rp_to_',
                                     remove_pkey=False,
                                     indent=4,
                                     skip_columns=['situation_geometry']),

           )

cursor.execute(view_sql)

trigger_insert_sql="""
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
            , fk_owner
            , fk_operator )

    VALUES ( COALESCE(NEW.fk_wastewater_structure,qgep_sys.generate_oid('qgep_od','channel')) -- obj_id
            , NEW.ws_accessibility
            , NEW.ws_contract_section
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

ALTER VIEW qgep_od.vw_qgep_reach ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','reach');

ALTER VIEW qgep_od.vw_qgep_reach ALTER rp_from_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','reach_point');
ALTER VIEW qgep_od.vw_qgep_reach ALTER rp_to_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','reach_point');
ALTER VIEW qgep_od.vw_qgep_reach ALTER fk_wastewater_structure SET DEFAULT qgep_sys.generate_oid('qgep_od','channel');
"""
