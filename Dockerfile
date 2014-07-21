FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# run pacman to install pre-req
RUN pacman -S python2 sqlite python2-pyopenssl unzip --noconfirm

# make destination folder
RUN mkdir /opt/moviegrabber

# download zip from github - url zip name is different to destination
ADD https://github.com/binhex/moviegrabber/archive/development.zip /opt/moviegrabber/moviegrabber-development.zip

# unzip to folder
RUN unzip /opt/moviegrabber/moviegrabber-development.zip -d /opt/moviegrabber

# move unzipped contents back to moviegrabber root
RUN mv /opt/moviegrabber/moviegrabber-development/* /opt/moviegrabber/

# remove files and folders
RUN rm /opt/moviegrabber/moviegrabber-development.zip
RUN rm -rf /opt/moviegrabber/moviegrabber-development/

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

# set permissions
#################

# change owner
RUN chown -R nobody:users /opt/moviegrabber

# set permissions
RUN chmod -R 775 /opt/moviegrabber

# add conf file
###############

ADD moviegrabber.conf /etc/supervisor/conf.d/moviegrabber.conf

# cleanup
#########

# completely empty pacman cache folder
RUN pacman -Scc --noconfirm

# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
