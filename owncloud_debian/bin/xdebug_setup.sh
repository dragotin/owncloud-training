#!/bin/bash

# https://oc.docker/status.php?XDEBUG_PROFILE

apt-get install -y php5-xdebug
mkdir -p /trace
chmod 777 /trace

rm /etc/php5/apache2/conf.d/20-xdebug.ini

echo "zend_extension=xdebug.so" > /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_host = champ.local" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_enable = 1" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_handler = dbgp" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.remote_mode = req" >> /etc/php5/apache2/conf.d/20-xdebug.ini

echo "xdebug.profiler_output_dir='/trace'" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.profiler_append=On" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.profiler_enable_trigger=On" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.profiler_output_name='cachegrind.out.%R-%u.trace'" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.trace_options=1" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.collect_params=4" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.collect_return=1" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.collect_vars=0" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.profiler_enable=0" >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.auto_trace=Off" >> /etc/php5/apache2/conf.d/20-xdebug.ini

echo "error_log = /var/log/php.log" >> /etc/php5/apache2/php.ini
