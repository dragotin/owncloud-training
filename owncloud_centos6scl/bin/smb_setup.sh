#!/bin/bash

# https://software.opensuse.org/download.html?project=isv%3AownCloud%3Acommunity%3A8.1&package=php5-libsmbclient

yum install -y samba-client unzip php56u-devel libsmbclient-devel libsmbclient
yum groupinstall "Development tools"

# php5-libsmbclient from source
cd root
wget https://github.com/eduardok/libsmbclient-php/archive/0.7.0.zip -O libsmbclient.zip
unzip libsmbclient.zip
cd libsmbclient-php-0.7.0

phpize
./configure
make
make install

yum groupremove "Development tools"
yum install -y php56u-devel libsmbclient-devel

echo "extension=libsmbclient.so" > /etc/php.d/20-libsmbclient.ini

echo "export HOME=/usr/share/httpd" >> /etc/sysconfig/httpd
echo "HOME=/usr/share/httpd" >> /etc/sysconfig/httpd


su apache -s /bin/bash -c 'php /var/www/owncloud/occ app:enable files_external'