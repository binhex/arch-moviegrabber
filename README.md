moviegrabber
============

Latest stable MovieGrabber Git release for Arch Linux.

This is a Dockerfile for MovieGrabber - http://forums.sabnzbd.org/viewtopic.php?f=6&t=8569

**Pull image**

```
docker pull binhex/arch-moviegrabber
```

**Run container**

```
docker run -d -p 9191:9191 --name=<container name> -v <path for media files>:/media -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-moviegrabber
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
http://<host ip>:9191
```