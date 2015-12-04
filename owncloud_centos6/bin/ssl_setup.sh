#!/bin/bash

echo "Setup SSL"
yum install -y mod_ssl openssl

[[ $1 == "strict" ]] && echo "Remove Port 80" && sed -i 's|Listen 80| |' /etc/httpd/conf/httpd.conf

sed -i 's|</VirtualHost>|\t<IfModule mod_headers.c>\n\t\t\tHeader always set Strict-Transport-Security "max-age=15768000; includeSubDomains; preload"\n\t\t</IfModule>\n\t</VirtualHost>|' /etc/httpd/conf.d/ssl.conf
