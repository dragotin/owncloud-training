#!/bin/bash

# restore:# mysql -u root -p[root_password] [database_name] < dumpfilename.sql

DB_PASS=$MARIADB_ENV_MARIADB_ROOT_PASSWORD

DATE=$1
mkdir -p /backup
[[ ! -d /backup/${DATE}-owncloud ]] && echo "Usage: restore.sh 2015-11-10" && echo "$(ls -la /backup)" && exit

su apache -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --on'

echo "- Restore DB"
mysql -u root -p$DB_PASS -h mariadb -e "drop database owncloud;"
mysql -u root -p$DB_PASS -h mariadb -e "create database owncloud;"
mysql -u root -p$DB_PASS -h mariadb owncloud < /backup/${DATE}-owncloud/db.sql

echo "- Restore Data"
rm -rf /mnt/data/*
cp -r /backup/${DATE}-owncloud/data/* /mnt/data/
chown -R apache.apache /mnt/data/

echo "- Restore Config"
rm -r /var/www/owncloud/config/*
cp -r /backup/${DATE}-owncloud/config/* /var/www/owncloud/config/
chown -R apache.apache /var/www/owncloud/config/

echo "Restored: /backup/${DATE}-owncloud"
su apache -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --off'

