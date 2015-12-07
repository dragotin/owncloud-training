#!/bin/bash

apt-get install -y \
    unzip \
    vim \
    mysql-client \
    git

OCDIR=/var/www/owncloud

echo -e '#!/bin/bash\ncd '$OCDIR'\nsu www-data -s /bin/bash -c "php '$OCDIR'/occ $@"\n' > /usr/local/bin/occ
chmod a+x /usr/local/bin/occ