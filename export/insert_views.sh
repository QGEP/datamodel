#!/bin/bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

psql -c "DROP SCHEMA IF EXISTS qgep_export CASCADE;"
psql -c "CREATE SCHEMA qgep_export;"


psql -v ON_ERROR_STOP=1 -c "$(${DIR}/vw_export_wasterwater_structure.py ${PGSERVICE})"
psql -v ON_ERROR_STOP=1 -c "$(${DIR}/vw_export_reach.py ${PGSERVICE})"
