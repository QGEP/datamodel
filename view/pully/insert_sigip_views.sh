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

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_troncons.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_ouvrages.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_noeuds.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_couvercles.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_details_ouvrages.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_file.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_files.sql
# psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_cr_photo_min.sql
# psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_cr_photo_max.sql
# psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_reach_from.sql
# psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/vw_export_reach_to.sql
