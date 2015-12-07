#!/bin/bash

echo "Install ownCloud"
docker exec -ti oc oc_install.sh

# docker exec -ti oc phpinfo.sh
# docker exec -ti oc loglevel.sh 0

echo "Setup SSL Self Signed Certificates for https"
docker exec -ti oc ssl_setup.sh strict

echo "Setup Redis for Transactional File Locking and Caching"
docker exec -ti oc redis_setup.sh

echo "Setup SMB / CIFS and External Storages"
docker exec -ti oc smb_setup.sh

echo "Setup LDAP"
docker exec -ti oc ldap_setup.sh
docker exec -ti oc killall -s HUP apache2

echo "Install Shibboleth"
docker exec -ti oc shib_install.sh

echo "Configure Apache for Shibboleth Authentication"
docker cp owncloud_debian/conf/shibd.conf oc:/etc/apache2/conf-enabled

echo "restart apache & shibd"
docker exec -ti oc killall -s HUP apache2
docker exec -ti oc service shibd start

echo "register & configure testshib.org"
docker exec -ti oc testshib_setup.sh

echo "restart apache & shibd"
docker exec -ti oc killall -s HUP apache2
docker exec -ti oc service shibd start


echo "Admin Access without Shibboleth Authentication: https://oc.docker/owncloud"
echo "Shibbolet Access: https://oc.docker"