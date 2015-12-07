#!/bin/bash

echo "Setup Redis for Transactional File Locking and Caching"
cd /var/www/owncloud

su apache -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set redis --value FIXME'
sed -i "s_'FIXME'_['host' => 'redis','port' => 6379,'timeout' => 0.0]_" /var/www/owncloud/config/config.php
su apache -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set memcache.local --value "\OC\Memcache\Redis"'
su apache -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set memcache.locking --value "\OC\Memcache\Redis"'
su apache -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set filelocking.enabled --value true'
