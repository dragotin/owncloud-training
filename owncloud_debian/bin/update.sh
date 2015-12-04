#!/bin/bash

mkdir -p /backup

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --on'


echo "" > /backup/update-schema.sql
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ db:generate-change-script' > /backup/update-schema.sql
echo "" > /backup/update-schema.sql

mysql -u root -psecret -h mariadb owncloud < /backup/update-schema.sql

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ upgrade --skip-migration-test'

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ maintenance:mode --off'