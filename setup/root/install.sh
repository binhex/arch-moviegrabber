#!/bin/bash

# exit script if return code != 0
set -e

# build scripts
####

# download build scripts from github
curl --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0 --retry-max-time 60 -o /tmp/scripts-master.zip -L https://github.com/binhex/scripts/archive/master.zip

# unzip build scripts
unzip /tmp/scripts-master.zip -d /tmp

# move shell scripts to /root
find /tmp/scripts-master/ -type f -name '*.sh' -exec mv -i {} /root/  \;

# pacman packages
####

# define pacman packages
pacman_packages="python2 sqlite python2-pyopenssl"

# install compiled packages using pacman
if [[ ! -z "${pacman_packages}" ]]; then
	pacman -S --needed $pacman_packages --noconfirm
fi

# aor packages
####

# define arch official repo (aor) packages
aor_packages=""

# call aor script (arch official repo)
source /root/aor.sh

# aur packages
####

# define aur packages
aur_packages=""

# call aur install script (arch user repo)
source /root/aur.sh

# call custom install script
source /root/custom.sh

# container perms
####

# create file with contets of here doc
cat <<'EOF' > /tmp/permissions_heredoc
# set permissions inside container
chown -R "${PUID}":"${PGID}" /opt/moviegrabber /home/nobody
chmod -R 775 /opt/moviegrabber /home/nobody

EOF

# replace permissions placeholder string with contents of file (here doc)
sed -i '/# PERMISSIONS_PLACEHOLDER/{
    s/# PERMISSIONS_PLACEHOLDER//g
    r /tmp/permissions_heredoc
}' /root/init.sh
rm /tmp/permissions_heredoc

# env vars
####

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /usr/share/gtk-doc/*
rm -rf /tmp/*
