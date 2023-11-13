#!/usr/bin/env python3
#
# -- View: vw_qgep_ws_symbol_xxxxxxx

import argparse
import os
import psycopg2
from yaml import safe_load
from pirogue.utils import select_columns, insert_command, update_command, table_parts


def vw_qgep_ws_symbol_plantype(srid: int,
                                 pg_service: str = None,
                                 extra_definition: dict = None,
                                 plantype_row: list = None):
    """
    Creates qgep_ws_symbol_xx views
    :param srid: EPSG code for geometries
    :param pg_service: the PostgreSQL service name
    :param extra_definition: a dictionary for additional read-only columns
    :param plantype_row: list of tuples of the plantype value list
    """
    if not pg_service:
        pg_service = os.getenv('PGSERVICE')
    assert pg_service
    extra_definition = extra_definition or {}

    variables = {'SRID': int(srid),
                'TYPECODE':int(plantype_row[0])  # code
                }

    conn = psycopg2.connect("service={0}".format(pg_service))
    cursor = conn.cursor()

    view_sql = """
    DROP VIEW IF EXISTS qgep_od.vw_qgep_ws_symbol_{typedef};

    CREATE OR REPLACE VIEW qgep_od.qgep_ws_symbol_{typedef} AS
     SELECT
        ws.identifier as identifier,

        CASE
          WHEN ma.obj_id IS NOT NULL THEN 'manhole'
          WHEN ss.obj_id IS NOT NULL THEN 'special_structure'
          WHEN dp.obj_id IS NOT NULL THEN 'discharge_point'
          WHEN ii.obj_id IS NOT NULL THEN 'infiltration_installation'
          ELSE 'unknown'
        END AS ws_type

        , ma.function AS ma_function
        , ss.function as ss_function
        , ws.fk_owner
        , ws.status

        {extra_cols}

        , {ws_cols}

        , main_co_sp.identifier AS co_identifier
        , main_co_sp.remark AS co_remark
        , main_co_sp.renovation_demand AS co_renovation_demand

        , {main_co_cols}
        , ST_Force2D(COALESCE(ws_sym.symbolpos_geometry, wn.situation_geometry, main_co.situation_geometry))::geometry(Point, %(SRID)s) AS situation_geometry

        , {ma_columns}

        , {ss_columns}

        , {ii_columns}

        , {dp_columns}

        , {wn_cols}
        , {ne_cols}
        , {ws_sym_cols}
        , ws._label
        , ws._cover_label
        , ws._bottom_label
        , ws._input_label
        , ws._output_label
        , ws._usage_current AS _channel_usage_current
        , ws._function_hierarchic AS _channel_function_hierarchic

        FROM qgep_od.wastewater_structure ws
        LEFT JOIN qgep_od.cover main_co ON main_co.obj_id = ws.fk_main_cover
        LEFT JOIN qgep_od.structure_part main_co_sp ON main_co_sp.obj_id = ws.fk_main_cover
        LEFT JOIN qgep_od.manhole ma ON ma.obj_id = ws.obj_id
        LEFT JOIN qgep_od.special_structure ss ON ss.obj_id = ws.obj_id
        LEFT JOIN qgep_od.discharge_point dp ON dp.obj_id = ws.obj_id
        LEFT JOIN qgep_od.infiltration_installation ii ON ii.obj_id = ws.obj_id
        LEFT JOIN qgep_od.wastewater_networkelement ne ON ne.obj_id = ws.fk_main_wastewater_node
        LEFT JOIN qgep_od.wastewater_node wn ON wn.obj_id = ws.fk_main_wastewater_node
        LEFT JOIN qgep_od.channel ch ON ch.obj_id = ws.obj_id
        LEFT JOIN (SELECT * from qgep_od.wastewater_structure_symbol WHERE ws_sym.plantype=%(TYPECODE)s) ws_sym ON ws_sym.fk_wastewater_structure = ws.obj_id
        {extra_joins}
        WHERE ch.obj_id IS NULL;

    """.format(extra_cols='\n    '.join([select_columns(pg_cur=cursor,
                                                        table_schema=table_parts(table_def['table'])[0],
                                                        table_name=table_parts(table_def['table'])[1],
                                                        skip_columns=table_def.get('skip_columns', []),
                                                        remap_columns=table_def.get('remap_columns', {}),
                                                        prefix=table_def.get('prefix', None),
                                                        table_alias=table_def.get('alias', None)
                                                        ) + ','
                                        for table_def in extra_definition.get('joins', {}).values()]),
               ws_cols=select_columns(pg_cur=cursor,
                                      table_schema='qgep_od',
                                      table_name='wastewater_structure',
                                      table_alias='ws',
                                      remove_pkey=False,
                                      indent=4,
                                      skip_columns=['identifier', 'fk_owner', 'status', '_label', '_cover_label', '_bottom_label', '_input_label', '_output_label', '_usage_current',
                                                    '_function_hierarchic', 'fk_main_cover', 'fk_main_wastewater_node', 'detail_geometry_geometry']),
               main_co_cols=select_columns(pg_cur=cursor,
                                           table_schema='qgep_od',
                                           table_name='cover',
                                           table_alias='main_co',
                                           remove_pkey=False,
                                           indent=4,
                                           skip_columns=['situation_geometry'],
                                           prefix='co_',
                                           remap_columns={'cover_shape': 'co_shape'},
                                           columns_at_end=['obj_id']),
               ma_columns=select_columns(pg_cur=cursor,
                                         table_schema='qgep_od',
                                         table_name='manhole',
                                         table_alias='ma',
                                         remove_pkey=True,
                                         indent=4,
                                         skip_columns=['function'],
                                         prefix='ma_',
                                         remap_columns={'_orientation': 'ma_orientation'}),
               ss_columns=select_columns(pg_cur=cursor,
                                         table_schema='qgep_od',
                                         table_name='special_structure',
                                         table_alias='ss',
                                         remove_pkey=True,
                                         indent=4,
                                         skip_columns=['function'],
                                         prefix='ss_',
                                         remap_columns={}),
               ii_columns=select_columns(pg_cur=cursor,
                                         table_schema='qgep_od',
                                         table_name='infiltration_installation',
                                         table_alias='ii',
                                         remove_pkey=True,
                                         indent=4,
                                         skip_columns=[],
                                         prefix='ii_',
                                         remap_columns={}),
               dp_columns=select_columns(pg_cur=cursor,
                                         table_schema='qgep_od',
                                         table_name='discharge_point',
                                         table_alias='dp',
                                         remove_pkey=True,
                                         indent=4,
                                         skip_columns=[],
                                         prefix='dp_',
                                         remap_columns={}),
               wn_cols=select_columns(pg_cur=cursor,
                                           table_schema='qgep_od',
                                           table_name='wastewater_node',
                                           table_alias='wn',
                                           remove_pkey=False,
                                           indent=4,
                                           skip_columns=['situation_geometry'],
                                           prefix='wn_',
                                           remap_columns={},
                                           columns_at_end=['obj_id']),
               ne_cols=select_columns(pg_cur=cursor,
                                           table_schema='qgep_od',
                                           table_name='wastewater_networkelement',
                                           table_alias='ne',
                                           remove_pkey=True,
                                           indent=4,
                                           skip_columns=[],
                                           prefix='wn_',
                                           remap_columns={}),
               ws_sym_cols=select_columns(pg_cur=cursor,
                                           table_schema='qgep_od',
                                           table_name='wastewater_structure_symbol',
                                           table_alias='ws_sym',
                                           remove_pkey=False,
                                           indent=4,
                                           skip_columns=['symbolpos_geometry'],
                                           prefix='ws_sym_',
                                           remap_columns={},
                                           columns_at_end=['obj_id']),
               extra_joins='\n    '.join(['LEFT JOIN {tbl} {alias} ON {jon}'.format(tbl=table_def['table'],
                                                                                    alias=table_def.get('alias', ''),
                                                                                    jon=table_def['join_on'])
                                          for table_def in extra_definition.get('joins', {}).values()]),
                typedef=psycopg2.sql.Identifier(plantype_row[2].replace(".", "_"))
               )

    cursor.execute(view_sql, variables)

    trigger_insert_sql="""
    CREATE OR REPLACE FUNCTION qgep_od.ft_qgep_ws_symbol_{typedef}_INSERT()
      RETURNS trigger AS
    $BODY$
    BEGIN

      NEW.identifier = COALESCE(NEW.identifier, NEW.obj_id);

    {insert_ws}

      CASE
        WHEN NEW.ws_type = 'manhole' THEN
        -- Manhole
    {insert_ma}

        -- Special Structure
        WHEN NEW.ws_type = 'special_structure' THEN
    {insert_ss}

        -- Discharge Point
        WHEN NEW.ws_type = 'discharge_point' THEN
    {insert_dp}

        -- Infiltration Installation
        WHEN NEW.ws_type = 'infiltration_installation' THEN
    {insert_ii}

        ELSE
         RAISE NOTICE 'Wastewater structure type not known (%)', NEW.ws_type; -- ERROR
      END CASE;

    {insert_wn}

      UPDATE qgep_od.wastewater_structure
        SET fk_main_wastewater_node = NEW.wn_obj_id
        WHERE obj_id = NEW.obj_id;

    {insert_vw_cover}

      UPDATE qgep_od.wastewater_structure
        SET fk_main_cover = NEW.co_obj_id
        WHERE obj_id = NEW.obj_id;
    
    {insert_ws_sym}
    
      RETURN NEW;
    END; $BODY$ LANGUAGE plpgsql VOLATILE;

    DROP TRIGGER IF EXISTS vw_qgep_ws_symbol_{typedef}_INSERT ON qgep_od.vw_qgep_ws_symbol_{typedef};

    CREATE TRIGGER vw_qgep_ws_symbol_{typedef}_INSERT INSTEAD OF INSERT ON qgep_od.vw_qgep_ws_symbol_{typedef}
      FOR EACH ROW EXECUTE PROCEDURE qgep_od.ft_vw_qgep_ws_symbol_{typedef}_INSERT();
    """.format(insert_ws=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='wastewater_structure',
                                        table_alias='ws',
                                        remove_pkey=False,
                                        indent=2,
                                        skip_columns=['_label', '_cover_label', '_bottom_label', '_input_label', '_output_label', '_usage_current', '_function_hierarchic',
                                                      'fk_main_cover', 'fk_main_wastewater_node', 'detail_geometry_geometry']),
               insert_ma=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='manhole',
                                        table_alias='ma',
                                        prefix='ma_',
                                        remove_pkey=False,
                                        indent=6,
                                        skip_columns=['_orientation'],
                                        remap_columns={'obj_id': 'obj_id'}),
               insert_ss=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='special_structure',
                                        table_alias='ss',
                                        prefix='ss_',
                                        remove_pkey=False,
                                        indent=6,
                                        remap_columns={'obj_id': 'obj_id'}),
               insert_dp=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='discharge_point',
                                        table_alias='dp',
                                        prefix='dp_',
                                        remove_pkey=False,
                                        indent=6,
                                        remap_columns={'obj_id': 'obj_id'}),
               insert_ii=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='infiltration_installation',
                                        table_alias='ii',
                                        prefix='ii_',
                                        remove_pkey=False,
                                        indent=6,
                                        remap_columns={'obj_id': 'obj_id'}),
               insert_wn=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='vw_wastewater_node',
                                        table_type='view',
                                        table_alias='wn',
                                        prefix='wn_',
                                        remove_pkey=False,
                                        pkey='obj_id',
                                        indent=6,
                                        insert_values={'identifier': "COALESCE(NULLIF(NEW.wn_identifier,''), NEW.identifier)",
                                                       'situation_geometry': 'ST_SetSRID(ST_MakePoint(ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), \'nan\'), {srid} )'.format(srid=srid),
                                                       'last_modification': 'NOW()',
                                                       'fk_provider': "COALESCE(NULLIF(NEW.wn_fk_provider,''), NEW.fk_provider)",
                                                       'fk_dataowner': "COALESCE(NULLIF(NEW.wn_fk_dataowner,''), NEW.fk_dataowner)",
                                                       'fk_wastewater_structure': 'NEW.obj_id'}),
               insert_vw_cover=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='vw_cover',
                                        table_type='view',
                                        table_alias='co',
                                        prefix='co_',
                                        remove_pkey=False,
                                        pkey='obj_id',
                                        indent=6,
                                        remap_columns={'cover_shape': 'co_shape'},
                                        insert_values={'identifier': "COALESCE(NULLIF(NEW.co_identifier,''), NEW.identifier)",
                                                       'situation_geometry': 'ST_SetSRID(ST_MakePoint(ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), \'nan\'), {srid} )'.format(srid=srid),
                                                       'last_modification': 'NOW()',
                                                       'fk_provider': 'NEW.fk_provider',
                                                       'fk_dataowner': 'NEW.fk_dataowner',
                                                       'fk_wastewater_structure': 'NEW.obj_id'}),
               insert_ws_sym=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='wastewater_structure_symbol',
                                        table_alias='ws_sym',
                                        prefix='ws_sym_',
                                        remove_pkey=False,
                                        pkey='obj_id',
                                        indent=6,
                                       insert_values={'plantype': plantype_row[0],
                                                       'symbolpos_geometry': 'ST_SetSRID(ST_MakePoint(ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry)), {srid} )'.format(srid=srid),
                                                       'last_modification': 'NOW()',
                                                       'fk_provider': 'NEW.fk_provider',
                                                       'fk_dataowner': 'NEW.fk_dataowner',
                                                       'fk_wastewater_structure': 'NEW.obj_id'}),
                typedef=psycopg2.sql.Identifier(plantype_row[2].replace(".", "_"))
               )

    cursor.execute(trigger_insert_sql)

    update_trigger_sql = """
    CREATE OR REPLACE FUNCTION qgep_od.ft_vw_qgep_ws_symbol_{typedef}_UPDATE()
      RETURNS trigger AS
    $BODY$
    BEGIN
      {update_co}
      {update_sp}
      {update_ws}
      {update_wn}
      
      {insert_ws_sym}
      ON CONFLICT (obj_id) DO UPDATE
      SET (symbol_scaling_height
      , symbol_scaling_width
      , symbolori
      , symbolpos_geometry
      , last_modification
      , fk_dataowner
      , fk_provider
      , fk_wastewater_structure
      )
      =
      (EXCLUDED.symbol_scaling_height
      , EXCLUDED.ws_sym_symbol_scaling_width
      , EXCLUDED.symbolori
      , EXCLUDED.symbolpos_geometry
      , EXCLUDED.last_modification
      , EXCLUDED.fk_dataowner
      , EXCLUDED.fk_provider
      , EXCLUDED.fk_wastewater_structure
      );

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
          {update_ma}

        WHEN NEW.ws_type = 'special_structure' THEN
          {update_ss}

        WHEN NEW.ws_type = 'discharge_point' THEN
          {update_dp}

        WHEN NEW.ws_type = 'infiltration_installation' THEN
          {update_ii}

        ELSE -- do nothing
      END CASE;


      RETURN NEW;
    END;
    $BODY$
    LANGUAGE plpgsql;



    DROP TRIGGER IF EXISTS vw_qgep_ws_symbol_{typedef}_UPDATE ON qgep_od.vw_qgep_ws_symbol_{typedef};

    CREATE TRIGGER vw_qgep_ws_symbol_{typedef}_UPDATE INSTEAD OF UPDATE ON qgep_od.vw_qgep_ws_symbol_{typedef}
      FOR EACH ROW EXECUTE PROCEDURE qgep_od.ft_vw_qgep_ws_symbol_{typedef}_UPDATE();
    """.format(
               update_co=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='cover',
                                        table_alias='co',
                                        prefix='co_',
                                        indent=6,
                                        skip_columns=['situation_geometry'],
                                        remap_columns={'cover_shape': 'co_shape'}),
               update_sp=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='structure_part',
                                        table_alias='sp',
                                        prefix='co_',
                                        indent=6,
                                        skip_columns=['fk_wastewater_structure'],
                                        update_values={'last_modification': 'NEW.last_modification',
                                                       'fk_dataowner': 'NEW.fk_dataowner',
                                                       'fk_provider': 'NEW.fk_provider'}),
               update_ws=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='wastewater_structure',
                                        table_alias='ws',
                                        remove_pkey=False,
                                        indent=6,
                                        skip_columns=['detail_geometry_geometry', 'last_modification',
                                                      '_usage_current', '_function_hierarchic', '_label', '_cover_label', '_bottom_label', '_input_label', '_output_label',
                                                      'fk_main_cover', 'fk_main_wastewater_node', '_depth'],
                                        update_values={}),
               update_ma=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='manhole',
                                        table_alias='ws',
                                        prefix='ma_',
                                        remove_pkey=True,
                                        indent=6,
                                        skip_columns=['_orientation'],
                                        remap_columns={'obj_id': 'obj_id'}),
               update_ss=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='special_structure',
                                        table_alias='ss',
                                        prefix='ss_',
                                        remove_pkey=True,
                                        indent=6,
                                        skip_columns=[],
                                        remap_columns={'obj_id': 'obj_id'}),
               update_dp=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='discharge_point',
                                        table_alias='dp',
                                        prefix='dp_',
                                        remove_pkey=True,
                                        indent=6,
                                        skip_columns=[],
                                        remap_columns={'obj_id': 'obj_id'}),
               update_ii=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='infiltration_installation',
                                        table_alias='ii',
                                        prefix='ii_',
                                        remove_pkey=True,
                                        indent=6,
                                        skip_columns=[],
                                        remap_columns={'obj_id': 'obj_id'}),
               update_wn=update_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='wastewater_node',
                                        table_alias='wn',
                                        prefix='wn_',
                                        indent=6,
                                        skip_columns=['situation_geometry']),
               insert_ws_sym=insert_command(pg_cur=cursor,
                                        table_schema='qgep_od',
                                        table_name='wastewater_structure_symbol',
                                        table_alias='ws_sym',
                                        prefix='ws_sym_',
                                        remove_pkey=False,
                                        pkey='obj_id',
                                        indent=6,
                                       insert_values={'plantype': plantype_row[0],
                                                       'symbolpos_geometry': 'ST_SetSRID(ST_MakePoint(ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry)), {srid} )'.format(srid=srid),
                                                       'last_modification': 'NOW()',
                                                       'fk_provider': 'NEW.fk_provider',
                                                       'fk_dataowner': 'NEW.fk_dataowner',
                                                       'fk_wastewater_structure': 'NEW.obj_id'}),
                typedef=psycopg2.sql.Identifier(plantype_row[2].replace(".", "_"))                         
               )

    cursor.execute(update_trigger_sql, variables)

    trigger_delete_sql = """
    CREATE OR REPLACE FUNCTION qgep_od.ft_vw_qgep_ws_symbol_{typedef}_DELETE()
      RETURNS trigger AS
    $BODY$
    DECLARE
    BEGIN
      DELETE FROM qgep_od.wastewater_structure_symbol WHERE obj_id = OLD.ws_sym_obj_id;
    RETURN OLD;
    END; $BODY$ LANGUAGE plpgsql VOLATILE;

    DROP TRIGGER IF EXISTS vw_qgep_ws_symbol_{typedef}_DELETE ON qgep_od.vw_qgep_ws_symbol_{typedef};

    CREATE TRIGGER vw_qgep_ws_symbol_{typedef}_DELETE INSTEAD OF DELETE ON qgep_od.vw_qgep_ws_symbol_{typedef}
      FOR EACH ROW EXECUTE PROCEDURE qgep_od.ft_vw_qgep_qgep_ws_symbol_{typedef}_DELETE();
    """.format(typedef=psycopg2.sql.Identifier(plantype_row[2].replace(".", "_")))
    cursor.execute(trigger_delete_sql, variables)

    extras = """
    ALTER VIEW qgep_od.vw_qgep_qgep_ws_symbol_{typedef} ALTER obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','wastewater_structure');
    ALTER VIEW qgep_od.vw_qgep_qgep_ws_symbol_{typedef} ALTER co_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','cover');
    ALTER VIEW qgep_od.vw_qgep_qgep_ws_symbol_{typedef} ALTER wn_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','wastewater_node');
    ALTER VIEW qgep_od.vw_qgep_qgep_ws_symbol_{typedef} ALTER ws_sym_obj_id SET DEFAULT qgep_sys.generate_oid('qgep_od','wastewater_structure_symbol');
    ALTER VIEW qgep_od.vw_qgep_qgep_ws_symbol_{typedef} ALTER ws_sym_plantype SET DEFAULT %(TYPECODE)s;
    """.format(typedef=psycopg2.sql.Identifier(plantype_row[2].replace(".", "_")))
    cursor.execute(extras)

    conn.commit()
    conn.close()


if __name__ == "__main__":
    # create the top-level parser
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--srid', help='EPSG code for SRID')
    parser.add_argument('-e', '--extra-definition', help='YAML file path for extra additions to the view')
    parser.add_argument('-p', '--pg_service', help='the PostgreSQL service name')
    args = parser.parse_args()
    srid = args.srid or os.getenv('SRID')
    pg_service = args.pg_service or os.getenv('PGSERVICE')
    extra_definition = safe_load(open(args.extra_definition)) if args.extra_definition else {}
    # symbol views
    connctn = psycopg2.connect("service={0}".format(pg_service))
    cursr = connctn.cursor()
    plantype_row_sql= "SELECT * from qgep_vl.wastewater_structure_symbol_plantype"
    cursr.execute(plantype_row_sql)
    rows = cursr.fetchall();
    cursr.close()
    connctn.close()
    for plantype_row in rows:
        vw_qgep_ws_symbol_plantype(srid=srid, pg_service=pg_service, extra_definition=extra_definition, plantype_row=plantype_row)
