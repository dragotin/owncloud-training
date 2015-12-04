#!/bin/bash

apt-get install -y unzip vim

OCDIR=/var/www/owncloud

echo -e '#!/bin/bash\ncd '$OCDIR'\nsu www-data -s /bin/bash -c "php '$OCDIR'/occ $@"\n' > /usr/bin/occ
chmod a+x /usr/bin/occ