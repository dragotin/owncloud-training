#!/bin/bash

# restore:# mysql -u root -p[root_password] [database_name] < dumpfilename.sql

DATE=$1
mkdir -p /backup
[[ ! -d /backup/${DATE}-owncloud ]] && echo "Usage: restore.sh 2015-11-10" && echo "$(ls -la /backup)" && exit

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --on'

echo "- Restore DB"
mysql -u root -psecret -h mariadb -e "drop database owncloud;"
mysql -u root -psecret -h mariadb -e "create database owncloud;"
mysql -u root -psecret -h mariadb owncloud < /backup/${DATE}-owncloud/db.sql

echo "- Restore Data"
rm -rf /mnt/data/*
cp -r /backup/${DATE}-owncloud/data/* /mnt/data/
chown -R www-data.www-data /mnt/data/

echo "- Restore Config"
rm -r /var/www/owncloud/config/*
cp -r /backup/${DATE}-owncloud/config/* /var/www/owncloud/config/
chown -R www-data.www-data /var/www/owncloud/config/

echo "Restored: /backup/${DATE}-owncloud"
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --off'

