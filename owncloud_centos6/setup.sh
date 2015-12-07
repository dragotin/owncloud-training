#!/bin/bash

echo "Install ownCloud"
docker exec -ti oc oc_install.sh

docker exec -ti oc phpinfo_setup.sh
docker exec -ti oc loglevel.sh 0

docker exec -ti oc ssl_setup.sh strict
docker exec -ti oc cron_setup.sh
docker exec -ti oc redis_setup.sh
docker exec -ti oc ldap_setup.sh
# docker exec -ti oc smb_setup.sh

echo "Install Shibboleth"
docker exec -ti oc shib_install.sh

echo "Configure Apache for Shibboleth Authentication"
docker cp conf/shibd.conf oc:/etc/httpd/conf.d/shib.conf

echo "restart apache & shibd"
docker exec -ti oc service httpd restart
docker exec -ti oc service shibd start

echo "register & configure testshib.org"
docker exec -ti oc testshib_setup.sh

echo "Admin Access without Shibboleth Authentication: https://oc.docker/owncloud"
echo "Shibbolet Access: https://oc.docker"


# Curl issue
# https://bugzilla.redhat.com/show_bug.cgi?id=1241172
# https://doc.owncloud.org/server/8.1/admin_manual/configuration_server/security_setup_warnings.html#outdated-nss-openssl-version