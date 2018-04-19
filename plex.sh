#!/bin/bash

# install plex using https://dev2day.de/plex-media-server-arm/
# add my public key
sudo wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add -
# add my PMS repo
sudo echo "deb https://dev2day.de/pms/ stretch main" >> sudo /etc/apt/sources.list.d/raspi.list
# activate https
sudo apt-get install apt-transport-https
# update the repos
sudo apt-get update
# install PMS
sudo apt-get install plexmediaserver-installer
