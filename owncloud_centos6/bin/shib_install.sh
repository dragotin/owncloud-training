#!/bin/bash

echo "Setup Shibboleth"
wget http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/security:shibboleth.repo -O /etc/yum.repos.d/security:shibboleth.repo
yum install -y shibboleth

service httpd restart
service shibd start

echo "Generate Shibboleth Keys"
/etc/shibboleth/keygen.sh -f

