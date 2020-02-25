#!/bin/bash

set -e

until psql --host postgis -U postgres -c '\q' > /dev/null 2>&1; do
  echo "waiting for postgres..."
  sleep 3
done

echo "Recreating database 'qgep_$1'"
psql --host postgis -U postgres -a -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$1'"
dropdb --host postgis -U postgres --if-exists qgep_$1
createdb --host postgis -U postgres qgep_$1

if [ "$1" == "release" ]; then

  echo "Installing demo data from release"
  pg_restore --host postgis -U postgres --dbname qgep_release --verbose --exit-on-error /data/demo_data.backup

elif [ "$1" == "release_struct" ]; then

  echo "Installing structure from release"
  psql "service=qgep_release_struct" -v ON_ERROR_STOP=1 -f /data/structure.sql

elif [ "$1" == "build" ]; then

  echo "Building database normally"
  PGSERVICE=qgep_build ./scripts/db_setup.sh

elif [ "$1" == "build_pum" ]; then

  echo "Building database through pum migrations"
  PGSERVICE=qgep_build_pum psql -v ON_ERROR_STOP=on -f test_data/data_fixes.sql
  pum restore -p qgep_build_pum -x --exclude-schema public --exclude-schema topology -- ./test_data/qgep_demodata_1.0.0.dump

else

  echo "Command must be one of [release | release_struct | build | build_pum]"
  exit 0

fi

echo "Done !"
