#!/bin/bash

# install ownCloud
cd /var/www/owncloud

su apache -s /bin/bash -c 'php occ  maintenance:install --database "mysql" --database-name "owncloud"  --database-host "mariadb" --database-user "root" --database-pass "secret" --admin-user "admin" --admin-pass "password" --data-dir "/mnt/data"'

OWNCLOUD_DOMAIN=${HOSTNAME}

sed -i "s_0 => 'localhost',_0 => 'localhost', 1 => '${OWNCLOUD_DOMAIN}',_" /var/www/owncloud/config/config.php 
su apache -s /bin/bash -c "php /var/www/owncloud/occ config:system:set overwrite.cli.url --value http://${OWNCLOUD_DOMAIN}"
