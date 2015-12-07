FROM debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -q -y \
        apt-utils \
        wget \
        curl \
        bzip2 \
        apache2 \
        libapache2-mod-php5 \
        php5-gd \
        php5-json \
        php5-mysql \
        php5-curl \
        php5-intl \
        php5-mcrypt \
        php5-imagick \
        php5-redis

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www
  
# apache modules oc needs as documented in 
# https://doc.owncloud.org/server/8.2/admin_manual/installation/source_installation.html#additional-apache-configurations
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod env
RUN a2enmod dir
RUN a2enmod mime

RUN mkdir -p /mnt/data
RUN chown www-data.www-data /mnt/data
        
EXPOSE 443
EXPOSE 80

RUN mkdir -p src
ADD start.sh src/start.sh
RUN chmod 0755 src/start.sh

ADD owncloud.tar.bz2 /var/www/
RUN chsh -s /bin/bash www-data
RUN chown -R www-data.www-data /var/www/owncloud
RUN sed -i 's_DocumentRoot /var/www/html_DocumentRoot /var/www/owncloud_' /etc/apache2/sites-enabled/000-default.conf

ADD bin src/bin
RUN chmod 0755 src/bin/*
RUN cp src/bin/* /usr/local/bin

CMD ["bash", "/src/start.sh"]

