FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# run pacman to install pre-req
RUN pacman -S python2 sqlite wget python2-pyopenssl --noconfirm

# pull app from github
RUN mkdir /opt/moviegrabber
RUN wget https://github.com/binhex/moviegrabber/tarball/1e2ba1deea205e817564105053981f43d4534595 -O /tmp/binhex-moviegrabber-1e2ba1d.tar.gz
RUN tar -C /opt/moviegrabber -xvf /tmp/binhex-moviegrabber-1e2ba1d.tar.gz --strip-components 1

# docker settings
#################

# set the docker locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8  

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

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
