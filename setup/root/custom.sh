#!/bin/bash

# exit script if return code != 0
set -e

# create destination directories
mkdir -p /opt/moviegrabber

# download moviegrabber from github
curl --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0 --retry-max-time 60 -o /opt/moviegrabber/moviegrabber-development.zip -L https://github.com/binhex/moviegrabber/archive/development.zip

# unzip moviegrabber and move
unzip /opt/moviegrabber/moviegrabber-development.zip -d /opt/moviegrabber
mv /opt/moviegrabber/moviegrabber-development/* /opt/moviegrabber

# remove source zip file and folder
rm /opt/moviegrabber/moviegrabber-development.zip
rm -rf /opt/moviegrabber/moviegrabber-development/
