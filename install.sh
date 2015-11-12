#!/bin/bash

# exit script if return code != 0
set -e

# define pacman packages
pacman_packages="python2 sqlite python2-pyopenssl unzip"

# install pre-reqs
pacman -Syu --ignore filesystem --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# create destination directories
mkdir -p /opt/moviegrabber

# download moviegrabber from github
curl -o /opt/moviegrabber/moviegrabber-development.zip -L https://github.com/binhex/moviegrabber/archive/development.zip

# unzip moviegrabber and move
unzip /opt/moviegrabber/moviegrabber-development.zip -d /opt/moviegrabber
mv /opt/moviegrabber/moviegrabber-development/* /opt/moviegrabber

# remove source zip file and folder
rm /opt/moviegrabber/moviegrabber-development.zip
rm -rf /opt/moviegrabber/moviegrabber-development/

# set permissions
chown -R nobody:users /opt/moviegrabber
chmod -R 775 /opt/moviegrabber

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
