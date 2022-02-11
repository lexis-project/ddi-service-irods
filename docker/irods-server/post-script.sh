#/bin/bash

PGDATA_DIR=/opt/irods-pgdata
PG_BIN=/usr/lib/postgresql/9.5/bin
IRODS_LIB=/var/lib/irods

chmod 777 /opt

# Create DB and start PostgreSQL server
su postgres  -c "cd && ${PG_BIN}/initdb -D ${PGDATA_DIR} && ${PG_BIN}/pg_ctl -D ${PGDATA_DIR} -l /tmp/postgres.log -w start"

# Create DB for ICAT server
PSQL='psql -h localhost -U postgres -d postgres'

$PSQL -c "CREATE USER irods WITH PASSWORD 'testpassword';"
$PSQL -c 'CREATE DATABASE "ICAT";'
$PSQL -c 'GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods;'

# Setup iRODS
cat provider.txt | python /var/lib/irods/scripts/setup_irods.py

# Copy the irods environment to be used by the user
su irods -c "cp ~/.irods/irods_environment.json /opt"
chmod a+r /opt/irods_environment.json

# All set, stop irods and postgres
su irods -c "${IRODS_LIB}/irodsctl stop"
su postgres -c "cd && ${PG_BIN}/pg_ctl -D ${PGDATA_DIR} -l /tmp/postgres.log -w stop"

# Set up permissions
chmod a+rx -R /opt/irods-pgdata
chmod a+rwx -R /etc/irods /var/lib/irods /run

# Delete old PID and lock dir for postgres
rm -rfv /run/postgresql
