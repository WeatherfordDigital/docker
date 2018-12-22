#!/bin/sh

# On Mac and Linux, use chmod +x to make this file executable. 


# cd into the root folder of the WP install
cd /your/wp/install/path

# make sure docker containers are updated. Remove these two lines if you're not using docker
/mnt/c/Program\ Files/Docker/Docker/resources/bin/docker-compose.exe  -f docker-compose.yml up -d
/mnt/c/Program\ Files/Docker/Docker/resources/bin/docker.exe exec galengrowth_wordpress_1 wp db export - | gzip > ./db_dump.sql.gz

# uncomment this line if you're not using docker
# wp db export - | gzip > ./db_dump.sql.gz

# compress WP install into an archive, ignoring version control files
tar --exclude-vcs -czfW dev.tar.gz .

# calculate the size of the archive
SIZE=$(du -hs dev.tar.gz)

# update this path to wherever you want the archive to be send to
mv dev.tar.gz /your/dropbox/path/goes/here
echo "Created archive ($SIZE) and moved it to Dropbox."

# clean up
rm db_dump.sql.gz
