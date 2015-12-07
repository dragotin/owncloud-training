#!/bin/bash

yum install -y php56u-ldap.x86_64
service httpd restart

cd /var/www/owncloud
su apache -s /bin/bash -c 'php /var/www/owncloud/occ app:enable user_ldap'
