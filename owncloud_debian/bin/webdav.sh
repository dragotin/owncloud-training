#!/bin/bash

USER=admin
PASSWORD=password

curl -k -XPOST https://$USER:$PASSWORD@oc.docker/ocs/v1.php/cloud/users -d userid="frank" -d password="frankspassword"
curl -k -XGET https://$USER:$PASSWORD@oc.docker/ocs/v1.php/cloud/users
