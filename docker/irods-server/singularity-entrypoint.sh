#!/usr/bin/env bash

PGDATA_DIR=/tmp/irods-pgdata
PG_BIN=/usr/lib/postgresql/9.5/bin

mkdir /run/postgresql
cp -rv /opt/irods-pgdata /tmp/
chmod -R 700 /tmp/irods-pgdata

mkdir ~/.irods
cp -v /opt/irods_environment.json ~/.irods

echo "Hostname: $(hostname)"

echo "Starting PostgreSQL server"
${PG_BIN}/pg_ctl -D ${PGDATA_DIR} -l /tmp/irods-postgres.log -w start

echo "Starting iRODS"
/var/lib/irods/irodsctl start

tail -f /dev/null
