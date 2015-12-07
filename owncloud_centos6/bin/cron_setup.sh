#!/bin/bash

echo "*/15  *  *  *  * php -f /var/www/owncloud/cron.php" > apache-cron
crontab -u apache apache-cron 

su apache -s /bin/bash -c 'php /var/www/owncloud/occ background:cron'