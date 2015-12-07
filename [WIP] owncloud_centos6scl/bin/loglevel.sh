#!/bin/bash

# https://doc.owncloud.org/server/8.2/admin_manual/configuration_server/config_sample_php_parameters.html#logging
# 0 = Debug, 1 = Info, 2 = Warning, 3 = Error, and 4 = Fatal

su apache -s /bin/bash -c 'php /var/www/owncloud/occ config:system:get loglevel'
[[ $# == 1 ]] && su apache -s /bin/bash -c "php /var/www/owncloud/occ config:system:set loglevel --value $1"