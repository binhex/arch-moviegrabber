**Application**

[MovieGrabber](https://github.com/binhex/moviegrabber)

**Application description**

MovieGrabber is a fully automated way of downloading movies from usenet or torrents, it supports any nzb client that has a "watched" or "monitor" folder facility such as Sabnzbd+, Grabit and Newsbin. MovieGrabber works by checking imdb for matching criteria and if a match is found the nzb will be downloaded and stored in either a specified queued folder for user review or sent to the watched folder for processing and automatic downloading via your usenet binary client.[

**Build notes**

Latest Github developer branch for MovieGrabber

**Usage**
```
docker run -d \
	-p 9191:9191 
	--name=<container name> 
	-v <path for media files>:/media 
	-v <path for data files>:/data 
	-v <path for config files>:/config 
	-v /etc/localtime:/etc/localtime:ro 
	binhex/arch-moviegrabber
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:9191`

**Example**
```
docker run -d \
	-p 9191:9191 
	--name=moviegrabber 
	-v /media/movies:/media 
	-v /apps/docker/sabnzbd/watched:/data 
	-v /apps/docker/moviegrabber:/config 
	-v /etc/localtime:/etc/localtime:ro 
	binhex/arch-moviegrabber
```

**Notes**

N/A

[Support forum](http://lime-technology.com/forum/index.php?topic=38055.0)