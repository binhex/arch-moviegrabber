**Application**

[MovieGrabber](https://github.com/binhex/moviegrabber)

**Description**

MovieGrabber is a fully automated way of downloading movies from usenet or torrents, it supports any nzb client that has a "watched" or "monitor" folder facility such as Sabnzbd+, Grabit and Newsbin. MovieGrabber works by checking imdb for matching criteria and if a match is found the nzb will be downloaded and stored in either a specified queued folder for user review or sent to the watched folder for processing and automatic downloading via your usenet binary client.[

**Build notes**

Latest Github developer branch for MovieGrabber

**Usage**
```
docker run -d \
    -p 9191:9191 \
    --name=<container name> \
    -v <path for media files>:/media \
    -v <path for data files>:/data \
    -v <path for config files>:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=<umask for created files> \
    -e PUID=<uid for user> \
    -e PGID=<gid for user> \
    binhex/arch-moviegrabber
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:9191`

**Example**
```
docker run -d \
    -p 9191:9191 \
    --name=moviegrabber \
    -v /media/movies:/media \
    -v /apps/docker/sabnzbd/watched:/data \
    -v /apps/docker/moviegrabber:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=000 \
    -e PUID=0 \
    -e PGID=0 \
    binhex/arch-moviegrabber
```

**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

```
id <username>
```
___
If you appreciate my work, then please consider buying me a beer  :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MM5E27UX6AUU4)

[Documentation](https://github.com/binhex/documentation) | [Support forum](http://forums.unraid.net/index.php?topic=45842.0)