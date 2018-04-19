#!/bin/bash

# install plex using https://dev2day.de/plex-media-server-arm/
# sudo user
sudo su
# add my public key
wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add -
# add my PMS repo
echo "deb https://dev2day.de/pms/ stretch main" >> /etc/apt/sources.list.d/pms.list
# activate https
apt-get install apt-transport-https -y
# update the repos
apt-get update
# install PMS
apt-get install plexmediaserver-installer -y
