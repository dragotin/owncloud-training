#!/bin/bash

# backup: # mysqldump -u root -p[root_password] [database_name] > dumpfilename.sql

DB_PASS=$MARIADB_ENV_MARIADB_ROOT_PASSWORD

DATE=$(date +%F)
rm -rf /backup/${DATE}-owncloud
mkdir -p /backup/${DATE}-owncloud

su apache -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --on'
mysqldump -u root -p$DB_PASS -h mariadb owncloud > /backup/${DATE}-owncloud/db.sql
cp -r /mnt/data /backup/${DATE}-owncloud/data
cp -r /var/www/owncloud/config /backup/${DATE}-owncloud/config
su apache -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --off'

echo "Backup created: /backup/${DATE}-owncloud"