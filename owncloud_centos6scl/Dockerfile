FROM centos:6

RUN yum -y update && yum install -y --nogpgcheck \
        wget \
        curl \
        https://www.softwarecollections.org/repos/rhscl/rh-php56/rhscl-rh-php56-el6-epel-6-x86_64/rh-php56-2.0-6.el6/rh-php56-2.0-6.el6.x86_64.rpm
        https://www.softwarecollections.org/en/scls/rhscl/rh-php56/epel-6-x86_64/download/rhscl-rh-php56-epel-6-x86_64.noarch.rpm
        https://www.softwarecollections.org/en/scls/rhscl/httpd24/epel-6-x86_64/download/rhscl-httpd24-epel-6-x86_64.noarch.rpm \
        https://www.softwarecollections.org/en/scls/rhscl/rh-php56/epel-6-x86_64/download/rhscl-rh-php56-epel-6-x86_64.noarch.rpm \
        && yum clean all

ENV TERM ansi 
ENV HOME /root


### Install PHP5.6
# RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
# RUN rpm -Uvh epel-release-latest-6*.rpm
# RUN wget https://centos6.iuscommunity.org/ius-release.rpm
# RUN rpm -Uvh ius-release*.rpm

# RUN yum -y update && yum install -y \
#         php56u-xml.x86_64 \
#          php56u-pecl-redis.x86_64 \
#          php56u.x86_64 \
#          php56u-common.x86_64 \
#          php56u-mysqlnd.x86_64 \
#          php56u-pear.noarch \
#          php56u-pecl-apcu.x86_64 \
#          php56u-pecl-imagick.x86_64 \
#          php56u-mbstring.x86_64 \
#          php56u-mcrypt.x86_64 \
#         php56u-gd.x86_64 \
#         && yum clean all

# Install ownCloud
RUN mkdir -p src
ADD owncloud.tar.bz2 src

# ownCloud unpacked automatically 
RUN mv src/owncloud /var/www/
RUN chown -R apache:apache /var/www/owncloud/

RUN sed -i 's_DocumentRoot "/var/www/html"_DocumentRoot "/var/www/owncloud"_' /etc/httpd/conf/httpd.conf

EXPOSE 80
EXPOSE 443

RUN mkdir -p /mnt/data
RUN chown -R apache.apache /mnt/data
        
EXPOSE 443
EXPOSE 80

ADD start.sh src/start.sh
RUN chmod 0755 src/start.sh

ADD bin src/bin
RUN chmod 0755 src/bin/*
RUN cp src/bin/* /usr/local/bin

CMD ["bash", "/src/start.sh"]
