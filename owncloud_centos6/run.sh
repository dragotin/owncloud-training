#!/bin/bash

docker build -t owncloud:centos6 .

docker rm -f oc
docker rm -f mariadb
docker rm -f redis

docker run -d --name redis webhippie/redis:latest
docker run -d --name mariadb -e MARIADB_ROOT_PASSWORD=secret  webhippie/mariadb:latest
docker run -d -e VIRTUAL_HOST=oc.docker -h oc.docker --name oc -p 443:443 --link mariadb --link redis owncloud:centos6

echo "Please add a hosts entry for owncloud in /etc/hosts"
# IP= 
echo "$IP oc.docker"
