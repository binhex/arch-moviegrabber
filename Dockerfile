FROM binhex/arch-base:2015010500
MAINTAINER binhex

# additional files
##################

# download zip from github - url zip name is different to destination
ADD https://github.com/binhex/moviegrabber/archive/development.zip /opt/moviegrabber/moviegrabber-development.zip

# add supervisor conf file for app
ADD moviegrabber.conf /etc/supervisor/conf.d/moviegrabber.conf

# add install bash script
ADD install.sh /root/install.sh

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/install.sh && \
	/bin/bash /root/install.sh
		
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