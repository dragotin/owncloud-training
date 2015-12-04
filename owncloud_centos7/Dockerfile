FROM centos:7

# Basic requirements
RUN 	yum -y  update 
RUN 	yum install -y wget tar bzip2 git

# Install Apache and Database
RUN yum install -y httpd mysql-server


### Installing optional ius repo
RUN     wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN 	rpm -Uvh epel-release-latest-7*.rpm
RUN		wget https://centos7.iuscommunity.org/ius-release.rpm 
RUN		rpm -Uvh ius-release*.rpm 

# Install PHP5.6

RUN yum install -y php56u-xml.x86_64 \
					php56u-pecl-redis.x86_64 \
 					php56u-soap.x86_64 \
 					php56u.x86_64 \
 					php56u-common.x86_64 \
 					php56u-mysqlnd.x86_64 \	
 					php56u-pear.noarch \
 					php56u-pecl-apcu.x86_64 \
 					php56u-pecl-imagick.x86_64 \
 					php56u-pecl-krb5.x86_64 \
 					php56u-pecl-memcache.x86_64 \
 					php56u-mbstring.x86_64 \
 					php56u-mcrypt.x86_64 \
	 					php56u-gd.x86_64 \

RUN yum clean all && yum update


# Install owncloud

RUN wget https://download.owncloud.org/community/owncloud-8.2.1.tar.bz2
RUN tar -xvf owncloud*
RUN mv owncloud /var/www/html/owncloud/
RUN chown -R apache.apache /var/www/html/owncloud/

