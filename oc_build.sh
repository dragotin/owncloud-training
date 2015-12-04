#!/bin/bash

wget $1 -O owncloud.tar.bz2

cp owncloud.tar.bz2 owncloud_debian/
cp owncloud.tar.bz2 owncloud_centos6/
cp owncloud.tar.bz2 owncloud_centos7/