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
cd ~
# create batch_convert file
cat > ~/batch_convert.sh << EOF
#!/bin/sh

# this will batch convert videos in raw_videos
# and put the converted video into plex_videos. It
# will also delete converted videos from raw_videos.

# converts filenames with spaces to underscores
find /home/pi/raw_videos/TV_Shows/* -name "* *" -type f | rename 's/ /_/g'
find /home/pi/raw_videos/Movies/* -name "* *" -type f | rename 's/ /_/g'


# converts videos to MP4 using HandBrakeCLI

for file in `ls /home/pi/raw_videos/TV_Shows`; do HandBrakeCLI -v -i /home/pi/raw_videos/TV_Shows/${file} -o /media/usb/plex/TV_Shows/"${file%.*}.mp4" -e x264 -b 3000 -T -E av_aac -B 192 -R 48 -d slow -5; done

for file in `ls /home/pi/raw_videos/Movies`; do HandBrakeCLI -v -i /home/pi/raw_videos/Movies/${file} -o /media/usb/plex/Movies/"${file%.*}.mp4" -e x264 -b 3000 -T -E av_aac -B 192 -R 48 -d slow -5; done


# cleanup raw_videos
rm /home/pi/raw_videos/TV_Shows/*
rm /home/pi/raw_videos/Movies/*

EOF

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
