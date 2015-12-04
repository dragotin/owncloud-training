#!/bin/bash

# https://doc.owncloud.org/server/8.2/admin_manual/configuration_user/user_provisioning_api.html

ADMIN=admin
PASSWORD=password

curl -k -XPOST https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users -d userid="frank" -d password="frankspassword"
curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users

# email, quota, display, password
curl -k -XPUT https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank -d key="email" -d value="franksnewemail@example.org"
curl -k -XPUT https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank -d key="quota" -d value="20M"
curl -k -XPUT https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank -d key="display" -d value="Frank"

exit

# More Examples:

curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank
curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank/groups

curl -k -XPOST https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank/groups -d groupid="newgroup"

curl -k -XDELETE https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank/groups -d groupid="newgroup"

curl -k -XPOST https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank/subadmins -d groupid="group"
curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank/subadmins
curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/groups/mygroup/subadmins

curl -k -XDELETE https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank/subadmins -d groupid="oldgroup"

curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/groups?search=adm
curl -k -XPOST https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/groups -d groupid="newgroup"
curl -k -XPOST https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/groups/admin

curl -k -XDELETE https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/groups/mygroup

curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/apps?filter=enabled
curl -k -XGET https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/apps/files

curl -k -XPOST https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/apps/files_texteditor
curl -k -XDELETE https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/apps/files_texteditor


curl -k -XDELETE https://$ADMIN:$PASSWORD@oc.docker/ocs/v1.php/cloud/users/frank