ngrinder docker 실행
====================

-	refer site :

> https://hub.docker.com/r/ngrinder/controller/

#### install

> controller install

```
$ docker pull ngrinder/controller:3.4
$ docker run -d -v ~/ngrinder-controller:/var/ngrinder/controller -p 80:80 -p 16001:16001 -p 12000-12009:12000-12009 -name ngrinder_controller ngrinder/controller:3.4
```

> agent install

```
$ docker pull ngrinder/agent:3.4 $ docker run -v ~/ngrinder-agent:/var/ngrinder/agent -d --name ngrinder_agent ngrinder/agent:3.4 192.168.1.7:80
```
