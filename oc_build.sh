#!/bin/bash

[[ ! -f owncloud.tar.bz2 ]] && [[ $# != 1 ]] \
  && echo "Usage: ./oc_build.sh https://download.owncloud.org/community/owncloud-8.2.1.tar.bz2" \
  && exit

[[ $# == 1 ]] \
  && echo "Downloading ownCloud from: $1" \
  && wget $1 -O owncloud.tar.bz2

cp owncloud.tar.bz2 owncloud_debian/
cp owncloud.tar.bz2 owncloud_centos6/
cp owncloud.tar.bz2 owncloud_centos7/

echo "Building Debian Image"
docker build -t owncloud:debian ./owncloud_debian/

echo "Building Centos6 Image"
docker build -t owncloud:centos6 ./owncloud_centos6/

echo "Building Centos7 Image"
docker build -t owncloud:centos7 ./owncloud_centos7/