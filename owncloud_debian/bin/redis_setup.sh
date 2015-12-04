#!/bin/bash

cd /var/www/owncloud

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set redis --value FIXME'
sed -i "s_'FIXME'_['host' => 'redis','port' => 6379,'timeout' => 0.0]_" /var/www/owncloud/config/config.php
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set memcache.local --value "\OC\Memcache\Redis"'
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set memcache.locking --value "\OC\Memcache\Redis"'
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ config:system:set filelocking.enabled --value true'
