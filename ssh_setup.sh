#!/bin/sh

# allow SSH through raspi-config
sudo raspi-config nonint do_ssh 1
