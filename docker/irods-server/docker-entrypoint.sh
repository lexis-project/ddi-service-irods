#!/usr/bin/env bash
PGDATA_DIR=/tmp/irods-pgdata
PG_BIN=/usr/lib/postgresql/9.5/bin
echo "Hostname: $(hostname)"

if [ -z "${ROLE}" ]
then
	ROLE="provider"
fi

if [[ ${ROLE}=="provider"  ]]
then

	echo "Creating PostgreSQL data dir at ${PGDATA_DIR}"
	su postgres -c "initdb -D ${PGDATA_DIR}"

	echo "Starting PostgreSQL server"
	su postgres -c "pg_ctl -D ${PGDATA_DIR} -l /tmp/irods-postgres.log -w start"


	INPUT_FILE="/opt/provider.txt"
	psql -U postgres -c "CREATE USER irods WITH PASSWORD 'testpassword';"
	psql -U postgres -c "CREATE DATABASE ICAT;"
	psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE ICAT TO irods;"
else
	INPUT_FILE="/opt/consumer.txt"
fi

echo "Setting up iRODS"
echo $INPUT_FILE
cat $INPUT_FILE | setup_irods


echo "Setting up B2SAFE"
source /etc/irods/service_account.config
su - $IRODS_SERVICE_ACCOUNT_NAME -s "/bin/bash" -c "cd /opt/eudat/b2safe/packaging/ ; ./install.sh"


echo "Starting iRDOS"
/etc/init.d/irods start

echo "Container "$(hostname)" is running."
tail -f /dev/null
~
