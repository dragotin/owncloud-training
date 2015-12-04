# Download

```
wget https://github.com/webhippie/owncloud-training/archive/master.zip
unzip master.zip
```

# Usage

Download owncloud and build ownCloud docker images

```
./oc_build <owncloud-download-url>
```

Or build with existing ```owncloud.tar.bz2``` file in basefolder
```
./oc_build
```

Choose a OS version

```
cd owncloud_debian
```

Start or restart ownCloud docker container

```
./run.sh
```

Install and setup a list of functions for ownCloud

```
./setup.sh
```

