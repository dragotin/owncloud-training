#!/bin/bash

echo "Setup LDAP"

cd /var/www/owncloud
su apache -s /bin/bash -c 'php /var/www/owncloud/occ app:enable user_ldap'
