#!/bin/bash

# backup: # mysqldump -u root -p[root_password] [database_name] > dumpfilename.sql

DATE=$(date +%F)
rm -rf /backup/${DATE}-owncloud
mkdir -p /backup/${DATE}-owncloud

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --on'
mysqldump -u root -psecret -h mariadb owncloud > /backup/${DATE}-owncloud/db.sql
cp -r /mnt/data /backup/${DATE}-owncloud/data
cp -r /var/www/owncloud/config /backup/${DATE}-owncloud/config
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --off'

echo "Backup created: /backup/${DATE}-owncloud"