#!/bin/bash

# exit script if return code != 0
set -e

repo_name="binhex"
app_name="moviegrabber"
install_name="moviegrabber"

# download install zip file
/root/curly.sh -rc 6 -rw 10 -of "/tmp/${app_name}.zip" -url "https://github.com/${repo_name}/${app_name}/archive/development.zip"

# unzip to /tmp
unzip "/tmp/${app_name}.zip" -d /tmp

# create destination directories
mkdir -p "/opt/${install_name}/"

# move to destination folder
mv /tmp/${app_name}*/* "/opt/${install_name}/"

# remove source zip file
rm "/tmp/${app_name}.zip"
