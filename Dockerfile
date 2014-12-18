FROM binhex/arch-base:2014101300
MAINTAINER binhex

# additional files
##################

# download zip from github - url zip name is different to destination
ADD https://github.com/binhex/moviegrabber/archive/development.zip /opt/moviegrabber/moviegrabber-development.zip

# add supervisor conf file for app
ADD moviegrabber.conf /etc/supervisor/conf.d/moviegrabber.conf

# install app
#############

# install base devel, install app using packer, set perms, cleanup
RUN pacman -Sy --noconfirm && \
	pacman -S python2 sqlite python2-pyopenssl unzip --noconfirm && \
	mkdir -p /opt/moviegrabber && \
	unzip /opt/moviegrabber/moviegrabber-development.zip -d /opt/moviegrabber && \
	mv /opt/moviegrabber/moviegrabber-development/* /opt/moviegrabber/ && \
	rm /opt/moviegrabber/moviegrabber-development.zip && \
	rm -rf /opt/moviegrabber/moviegrabber-development/ && \
	chown -R nobody:users /opt/moviegrabber && \
	chmod -R 775 /opt/moviegrabber && \
	pacman -Scc --noconfirm && \
	rm -rf /archlinux/usr/share/locale && \
	rm -rf /archlinux/usr/share/man && \
	rm -rf /root/* && \
	rm -rf /tmp/*
		
# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store data from app)
VOLUME /data

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# expose port for http
EXPOSE 9191

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]