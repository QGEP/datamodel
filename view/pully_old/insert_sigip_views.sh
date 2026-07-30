#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

psql "service=${PGSERVICE}" -c "DROP SCHEMA IF EXISTS qgep_sigip CASCADE;"
psql "service=${PGSERVICE}" -c "CREATE SCHEMA qgep_sigip;"
psql "service=${PGSERVICE}" -c "GRANT USAGE ON SCHEMA qgep_sigip TO qgep_viewer;"
psql "service=${PGSERVICE}" -c "GRANT ALL ON SCHEMA qgep_sigip TO qgep_user;"
psql "service=${PGSERVICE}" -c "COMMENT ON SCHEMA qgep_sigip IS 'QGEP SIGIP export views';"
psql "service=${PGSERVICE}" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sigip GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;"
psql "service=${PGSERVICE}" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sigip GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON TABLES TO qgep_user;"
psql "service=${PGSERVICE}" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_sigip GRANT SELECT, UPDATE, USAGE ON SEQUENCES TO qgep_user;"

# Create views

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_reach.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_wastewater_structure.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_wastewater_node.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_cover.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_detail_structure.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_file.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_files.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_cr_photo_min.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_cr_photo_max.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_reach_from.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_reach_to.sql
