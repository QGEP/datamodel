rem bat and sql in the same directory
set PATH=%PATH%;C:\Program Files\PostgreSQL\9.4\bin
rem base: psql -h %localhost% -p 5432 -U %postgres% -d %qgep% -f 'xy.sql'
rem works for database "qgep" on localhost
psql -U postgres -d qgep -f 00_sia405_schema_generate.sql
psql -U postgres -d qgep -f 01_sia405_tid_generate.sql
psql -U postgres -d qgep -f 02_sia405_tid_lookup.sql
rem gewünschtes schema erzeugen sia405abwasser (version 2015)
psql -U postgres -d qgep -f 03_sia405abwasser_2015_schema.sql
psql -U postgres -d qgep -f 042_sia405_t_ili2db_attrname_add_column_owner_for_ili2pg301.sql
psql -U postgres -d qgep -f 043_sia405_insert_t_ili2db_attrname_metadata.sql
psql -U postgres -d qgep -f 044_sia405_t_ili2db_classname_SIA405_ABWASSER_2015_2.sql
psql -U postgres -d qgep -f 045_sia405_t_ili2db_model_VSA_DSS_2015_2.ili_metadata.sql
psql -U postgres -d qgep -f 046_sia405_t_key_object_insert_metadata.sql
psql -U postgres -d qgep -f 051_sia405_interlisexport2.sql
psql -U postgres -d qgep -f 0511_geoAbwBW.sql
psql -U postgres -d qgep -f 052a_sia405_interlisexport2.sql
pause
rem takes xx sec