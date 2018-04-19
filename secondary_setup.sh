#!/bin/sh

# allow SSH through raspi-config
sudo raspi-config nonint do_ssh 1


# start plex every time system starts up
cat > ~/.bash_profile << EOF

sudo service plexmediaserver stop
sudo service plexmediaserver start

EOF

# set up static IP
cat >> /etc/dhcpcd.conf << EOF

# static IP
interface eth0

static ip_address=192.168.0.10/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1

EOF

