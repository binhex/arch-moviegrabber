#!/bin/bash

# exit script if return code != 0
set -e

# define pacman packages
pacman_packages="python2 sqlite python2-pyopenssl unzip"

# install pre-reqs
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

# install pip
curl -o /tmp/pip.tar.gz -L https://pypi.python.org/packages/source/p/pip/pip-8.1.1.tar.gz#md5=6b86f11841e89c8241d689956ba99ed7
cd /tmp; tar -xvf /tmp/pip.tar.gz
cd /tmp/pip*; /usr/bin/python2 setup.py install

# install pip wheel archives
/usr/bin/pip install --force-reinstall --ignore-installed --upgrade --no-index --no-deps --no-cache-dir /opt/moviegrabber/wheel/*

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
