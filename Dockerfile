FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# run pacman to install pre-req
RUN pacman -S python2 sqlite wget python2-pyopenssl unzip --noconfirm

# make destination folder
RUN mkdir /opt/moviegrabber

# download zip from github
ADD https://github.com/binhex/moviegrabber/archive/moviegrabber-master.zip /opt/moviegrabber

# unzip to folder - j option prevents recreation of zipped folder structure
RUN unzip -j /opt/moviegrabber/moviegrabber-master.zip -d /opt/moviegrabber

# remove zip
RUN rm /opt/moviegrabber/moviegrabber-master.zip

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
