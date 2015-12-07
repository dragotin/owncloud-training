#!/bin/bash

yum -y update && yum install -y \
    mysql \
    unzip \
    vim \
    tar \
    bzip2 \
    git

OCDIR=/var/www/owncloud

echo -e '#!/bin/bash\ncd '$OCDIR'\nsu apache -s /bin/bash -c "php '$OCDIR'/occ $@"\n' > /usr/bin/occ
chmod a+x /usr/bin/occ