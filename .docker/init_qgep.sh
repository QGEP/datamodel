#!/bin/bash

set -e

until psql -U postgres -c '\q' > /dev/null 2>&1; do
  echo "waiting for postgres..."
  sleep 3
done

recreate_db(){
  echo "Database $1 : recreating..."
  psql -U postgres -o /dev/null -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$1'"
  dropdb -U postgres --if-exists $1
  createdb -U postgres $1
}

if [ "$1" == "wait" ]; then

  until [ -f ${PGDATA}/entrypoint-done-flag ]; do
    echo "waiting for initialization to complete..."
    sleep 3
  done
  echo "Initialization complete !"
  # Let some time for postgres to restart...
  sleep 3
  exit 0

fi

if [ "$1" == "release" ]; then
  
  echo '----------------------------------------'
  echo "Installing demo data from release"

  FILE="/downloads/${2}.backup"

  if [ ! -f "$FILE" ]; then
    wget -nv https://github.com/QGEP/datamodel/releases/download/${2}/qgep_v${2}_structure_and_demo_data.backup -O $FILE
  fi

  recreate_db "qgep_release"
  pg_restore -U postgres --dbname qgep_release --verbose --exit-on-error "$FILE"

  echo "Done ! Database qgep_release can now be used."
  echo '----------------------------------------'

fi

if [ "$1" == "release_struct" ]; then

  echo '----------------------------------------'
  echo "Installing structure from release"

  FILE="/downloads/${2}.sql"

  if [ ! -f "$FILE" ]; then
    wget -nv https://github.com/QGEP/datamodel/releases/download/${2}/qgep_v${2}_structure_with_value_lists.sql -O $FILE
  fi

  recreate_db "qgep_release_struct"
  psql "service=qgep_release_struct" -v ON_ERROR_STOP=1 -f "$FILE"

  echo "Done ! Database qgep_release_struct can now be used."
  echo '----------------------------------------'

fi

if [ "$#" == "0" ] || [ "$1" == "build" ]; then

  recreate_db "qgep_build"
  echo '----------------------------------------'
  echo "Building database normally"

  PGSERVICE=qgep_build ./scripts/db_setup.sh

  echo "Done ! Database qgep_build can now be used."
  echo '----------------------------------------'

fi

if [ "$#" == "0" ] || [ "$1" == "build_pum" ]; then

  recreate_db "qgep_build_pum"
  echo '----------------------------------------'
  echo "Building database through pum migrations"

  pum restore -p qgep_build_pum -x --exclude-schema public --exclude-schema topology -- ./test_data/qgep_demodata_1.0.0.dump
  PGSERVICE=qgep_build_pum psql -v ON_ERROR_STOP=on -f test_data/data_fixes.sql
  pum baseline -p qgep_build_pum -t qgep_sys.pum_info -d ./delta/ -b 1.0.0
  pum upgrade -p qgep_build_pum -t qgep_sys.pum_info -d ./delta/ -v int SRID 2056

  echo "Done ! Database qgep_build_pum can now be used."
  echo '----------------------------------------'

fi

# echo '----------------------------------------'
# echo "Updating postgis if needed"
# update-postgis.sh

echo "done" > ${PGDATA}/entrypoint-done-flag
