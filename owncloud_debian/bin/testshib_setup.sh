#!/bin/bash

UUID=$(cat /proc/sys/kernel/random/uuid)
OWNCLOUD_DOMAIN=${HOSTNAME}

sed -i "s_https://sp.example.org/shibboleth_${UUID}_" /etc/shibboleth/shibboleth2.xml
service shibd restart

echo "register at testshib.org with UUID: $UUID"
cd /etc/shibboleth
wget https://$OWNCLOUD_DOMAIN/Shibboleth.sso/Metadata -O Metadata-$UUID.xml --no-check-certificate
echo -ne "--FILEUPLOAD\r\nContent-Disposition: form-data; name=\"userfile\"; filename=\"Metadata-${UUID}.xml\"\r\nContent-Type: text/xml\r\n\r\n" > postfile
cat Metadata-${UUID}.xml >> postfile
echo -ne "\r\n--FILEUPLOAD--\r\n" >> postfile
wget --header="Content-type: multipart/form-data boundary=FILEUPLOAD" --post-file postfile https://www.testshib.org/procupload.php

echo "configure testshib.org"
cd /etc/shibboleth
cp shibboleth2.xml shibboleth2.xml.bak
wget "https://www.testshib.org/cgi-bin/sp2config.cgi?dist=Others&hostname=$OWNCLOUD_DOMAIN" -O shibboleth2.xml
sed -i "s_https://$OWNCLOUD_DOMAIN/shibboleth_${UUID}_" /etc/shibboleth/shibboleth2.xml

# Now we need to actually protect owncloud with shibboleth
# Alternativ: https://doc.owncloud.org/server/8.2/admin_manual/enterprise_user_management/user_auth_shibboleth.html
# sed -i 's|</VirtualHost>|\t<Location "/">\n\t\t\tAuthType shibboleth\n\t\t\tShibRequestSetting requireSession 1\n\t\t\tRequire shib-session\n\t\t</Location>\n\t</VirtualHost>|' /etc/apache2/sites-enabled/default-ssl.conf

echo "setup Shibboleth in ownCloud"
cd /var/www/owncloud
su www-data -s /bin/bash -c 'php occ app:enable user_shibboleth'
su www-data -s /bin/bash -c 'php occ shibboleth:mode ssoonly'

echo "create testshib users"
su www-data -s /bin/bash -c 'OC_PASS=myself php occ user:add myself@testshib.org --password-from-env'
su www-data -s /bin/bash -c 'OC_PASS=alterego php occ user:add alterego@testshib.org --password-from-env'
su www-data -s /bin/bash -c 'OC_PASS=superego php occ user:add superego@testshib.org --password-from-env'
