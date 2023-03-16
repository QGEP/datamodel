#!/usr/bin/env bash

# PG Services
SRC_SRV=pg_qgep_sige
DEST_SRV=pg_qgep_new
# Databases
SRC_DB=qgep_sige
DEST_DB=qgep_new


set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# GNU prefix command for mac os support (gsed, gsplit)
GP=
if [[ "$OSTYPE" =~ darwin* ]]; then
  GP=g
fi

# Create a new DB with the existing as template
psql "service=$SRC_SRV" -c "DROP DATABASE IF EXISTS $DEST_DB"
psql "service=$SRC_SRV" -c "CREATE DATABASE $DEST_DB WITH TEMPLATE $SRC_DB"

# Create new schemas in same DB to ease table copying
echo "*** init empty QGEP db"
export PGOPTIONS='--client-min-messages=warning'
${DIR}/../db_setup.sh -p $DEST_SRV >/dev/null

# Copy tables
echo "*** copy tables"
export PGOPTIONS='--client-min-messages=notice'
psql "service=$DEST_SRV" -f ${DIR}/migrate_dispatch_copy_data.sql 2> migration.log
cat migration.log | ${GP}sed 's/\bERROR:/ZERROR:/' | ${GP}sed -r 's/^.*(INFO|NOTICE|WARNING|ERROR)/\1/' | ${GP}sort -r | ${GP}sed 's/\bZERROR:/ERROR:/' > migration2.log
CERR=$(cat migration2.log | ${GP}egrep 'ERROR:' | wc -l)
CWARN=$(cat migration2.log | ${GP}egrep 'WARNING:' | wc -l)
CNOT=$(cat migration2.log | ${GP}egrep 'NOTICE:' | wc -l)
cat migration2.log | ${GP}sort
if [[ "$CERR" -ne "0" ]]; then
  echo "!!! Migration failed with ${CERR} errors and ${CWARN} warnings."
else
  echo "**************"
  echo "**************"
  echo " Migration done with"
  echo "  ${CWARN} warnings"
  echo "  ${CNOT} notices (columns skip or rename)."
  echo "**************"
  cat migration2.log | ${GP}egrep 'WARNING:' || /bin/true
  echo "**************"
  cat migration2.log | ${GP}egrep '[^0]\d* elements' | ${GP}sed 's/INFO:\s*/ /'
  echo "**************"
  echo "**************"
fi
rm migration.log
rm migration2.log
