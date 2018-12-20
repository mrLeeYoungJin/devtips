docker 명령어
=============

설치 shell

```
$ curl -s https://get.docker.com/ | sudo sh
$ service docker startup
$ docker ps
```

build
-----

### Dockerfile 경로 위치에서 실행

```
$ docker build --tag gwlab/project .
```

> 옵션 <br/> -f dockerfilename

run

```
$ docker run -d --name project -p 8080:8080 gwlab/project
```

> 옵션 <br/> -v hostdir:containerdir <br/> --net=bridge<br/> --link mysql:mysql<br/> -p 8080:8080 <br/> --name mysql <br/> -e 환경변수

container delete
----------------

```
$ docker rm -f project

# all delete
$ docker rm $(docker ps -a -q)
```

images delete
-------------

```
$ docker rmi gwlab/project
or
$ docker rmi tagId
```

tar save and load
-----------------

```
$ docker save -o gwee_influxdb.tar gwee/influxdb:latest

$ docker load < gwee_influxdb.tar
```

file copy
---------

```
$ docker cp container:path dest_path
```

create
------

```
$ docker create --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD_FILE=/run/db_root_password -d mysql:5.7
```

start
-----

```
$ docker start mysql
```

network 정보 확인
-----------------

```
$ docker network ls
```

docker 설정 정보 확인
---------------------

```
$ docker inspect mysql

$ docker inspect -f "{{ .NetworkSettings.IPAddress }}" CONTAINER_ID
```

docker host정보 확인
--------------------

```
$ cat `sudo docker inspect -f "{{ .HostsPath }}" tomcat1`
```

docker images 삭제

```
## 전체 이미지 삭제
$ docker rmi $(docker images -q)
## none 이지지만 삭제
$ docker rmi $(docker images -f "dangling=true" -q)
```
