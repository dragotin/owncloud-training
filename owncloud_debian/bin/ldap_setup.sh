#!/bin/bash

apt-get install -y php5-ldap

cd /var/www/owncloud
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ app:enable user_ldap'
