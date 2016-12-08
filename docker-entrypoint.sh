#!/bin/bash
set -eu

POSTGRES_TIMEOUT=30

set +e
# Wait for Postgres to be available
# Strategy from http://superuser.com/a/806331/98716
DATABASE_DEV="/dev/tcp/${DATABASE_HOSTNAME}/5432"
echo "Checking datbase connection ${DATABASE_DEV}"
timeout ${POSTGRES_TIMEOUT} bash <<EOT
while ! (echo > "${DATABASE_DEV}") >/dev/null 2>&1; do
    echo "Waiting for database ${DATABASE_DEV}"
    sleep 2;
done;
EOT
RESULT=$?

if [ ${RESULT} -eq 0 ]; then
    echo "Database available"
else
    echo "Database is not available"
    exit 1
fi
set -e

# TODO: check if database exists before proceeding
mix ecto.create

# TODO: check if table exists before proceeding
mix ecto.migrate

mix server
