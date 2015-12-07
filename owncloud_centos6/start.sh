#!/bin/bash

# Start apache
service httpd start

# Start Cron Jobs
service crond start

# Start Shibboleth Deamon
[[ -f /etc/sysconfig/shibd ]] && service shibd start

# ! Not for production
while true; do echo 'Hit CTRL+C'; sleep 1; done
