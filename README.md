# Raspberry-Plex
A project for using the raspberry pi to convert videos and deliver them using Plex.

## Setting up Raspberry Pi
1. Install Raspbian onto an SD card using [Etcher](https://www.raspberrypi.org/documentation/installation/installing-images/)
1. Run [initial_setup.sh](initial_setup.sh) on the pi
1. After automatic reboot, run [secondary_setup.sh](secondary_setup.sh)

  * This will enable local network ssh access, setup autostart plex on reboot, setup static IP

## Accessing your Pi via SSH
1. Use `ifconfig` on the pi to get it's ipaddress
1. On your host machine, use `ssh pi@<IP>` to access it on the local network
1. To access plex via localhost, use `<ip>:32400/web`
