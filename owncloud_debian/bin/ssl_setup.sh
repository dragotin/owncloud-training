#!/bin/bash

a2enmod ssl
a2ensite default-ssl

[[ $1 == "strict" ]] && rm /etc/apache2/sites-enabled/000-default.conf

sed -i 's_DocumentRoot /var/www/html_DocumentRoot /var/www/owncloud_' /etc/apache2/sites-enabled/default-ssl.conf
sed -i 's|</VirtualHost>|\t<IfModule mod_headers.c>\n\t\t\tHeader always set Strict-Transport-Security "max-age=15768000; includeSubDomains; preload"\n\t\t</IfModule>\n\t</VirtualHost>|' /etc/apache2/sites-enabled/default-ssl.conf
