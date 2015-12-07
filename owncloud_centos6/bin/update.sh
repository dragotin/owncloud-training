#!/bin/bash

DB_PASS=$MARIADB_ENV_MARIADB_ROOT_PASSWORD

mkdir -p /backup

service httpd stop
service crond stop

# sleep 300 # wait for running cron jobs

# Wrap all Schema changes in a transaction
echo "START TRANSACTION;" > /backup/update-schema.sql
su apache -s /bin/bash -c 'php /var/www/owncloud/occ db:generate-change-script' > /backup/update-schema.sql
echo "COMMIT;" > /backup/update-schema.sql

mysql -u root -p$DB_PASS -h mariadb owncloud < /backup/update-schema.sql

su apache -s /bin/bash -c 'php /var/www/owncloud/occ upgrade --skip-migration-test'

service httpd start
service crond start
