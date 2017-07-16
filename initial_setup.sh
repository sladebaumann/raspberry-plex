#!/bin/bash

# Many of these steps come from [biglesp](https://www.element14.com/community/community/raspberry-pi/raspberrypi_projects/blog/2016/03/11/a-more-powerful-plex-media-server-using-raspberry-pi-3)

# set up basic tools
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y vim screen git

# install handbrake
# Thanks to gkreidl - https://www.raspberrypi.org/forums/viewtopic.php?f=66&t=142015#
sudo apt-get install gdebi-core
wget http://steinerdatenbank.de/software/ghb_0.10.5-1_armhf.deb
sudo gdebi ghb_0.10.5-1_armhf.deb

# setup handbrake to batch convert videos
# see - https://serato.com/forum/discussion/125664

# install plex packages
sudo apt-get install apt-transport-https -y --force-yes
wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key  | sudo apt-key add -
echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list
sudo apt-get update -y
sudo apt-get install -t jessie plexmediaserver -y

# setup vim colors using molokai colorscheme from https://github.com/tomasr/molokai
mkdir -p ~/.vim/colors
cd ~/.vim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
cd ~

# vim setup
cat > ~/.vimrc << EOF
set number                                                                
set cursorline
set showmatch
colorscheme molokai
syntax on
EOF

# colorize terminal for macosx
cat > ~/.bash_profile << EOF
# Command line fixes
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
EOF

# reboot to avoid any plex server errors
sudo reboot
