#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

psql -c "DROP SCHEMA IF EXISTS qgep_export CASCADE;"
psql -c "CREATE SCHEMA qgep_export;"

pirogue simple_joins ${DIR}/vw_export_reach.yaml --pg_service ${PGSERVICE}
pirogue simple_joins ${DIR}/vw_export_wastewater_structure.yaml --pg_service ${PGSERVICE}
