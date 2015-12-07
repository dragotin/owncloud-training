#!/bin/bash

printf "<?php\nphpinfo();\n" > /var/www/owncloud/phpinfo.php

echo "Find PHP Info at http://oc.docker/phpinfo.php"