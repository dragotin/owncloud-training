#!/bin/bash

# https://software.opensuse.org/download.html?project=isv%3AownCloud%3Acommunity%3A8.1&package=php5-libsmbclient

wget -q http://download.opensuse.org/repositories/isv:ownCloud:community:8.0/Debian_8.0/Release.key -O- | apt-key add -
echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community:/8.1/Debian_8.0/ /' > /etc/apt/sources.list.d/php5-libsmbclient.list
apt-get update
apt-get install -y --force-yes smbclient php5-libsmbclient

# echo "extension=libsmbclient.so" > /etc/php5/apache2/conf.d/20-libsmbclient.ini
# echo "extension=libsmbclient.so" > /etc/php5/cli/conf.d/20-libsmbclient.ini

cd /var/www/owncloud
su www-data -s /bin/bash -c 'php /var/www/owncloud/occ app:enable files_external'