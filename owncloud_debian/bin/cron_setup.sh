#!/bin/bash

echo "*/15  *  *  *  * php -f /var/www/owncloud/cron.php" > apache-cron
crontab -u www-data apache-cron 

su www-data -s /bin/bash -c 'php /var/www/owncloud/occ background:cron'