#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

psql "service=${PGSERVICE}" -c "DROP SCHEMA IF EXISTS qgep_export CASCADE;"
psql "service=${PGSERVICE}" -c "CREATE SCHEMA qgep_export;"
psql "service=${PGSERVICE}" -c "GRANT USAGE ON SCHEMA qgep_export TO qgep_viewer;"
psql "service=${PGSERVICE}" -c "GRANT ALL ON SCHEMA qgep_export TO qgep_user;"
psql "service=${PGSERVICE}" -c "COMMENT ON SCHEMA qgep_export IS 'QGEP export views';"
psql "service=${PGSERVICE}" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_export GRANT SELECT, REFERENCES, TRIGGER ON TABLES TO qgep_viewer;"
psql "service=${PGSERVICE}" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_export GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON TABLES TO qgep_user;"
psql "service=${PGSERVICE}" -c "ALTER DEFAULT PRIVILEGES IN SCHEMA qgep_export GRANT SELECT, UPDATE, USAGE ON SEQUENCES TO qgep_user;"

pirogue simple_joins ${DIR}/vw_export_reach.yaml --pg_service ${PGSERVICE}
pirogue simple_joins ${DIR}/vw_export_wastewater_structure.yaml --pg_service ${PGSERVICE}
