docker 명령어
=============

> 설치 shell

```
$ curl -s https://get.docker.com/ | sudo sh
$ service docker startup
$ docker ps
```

> build <br />
>
> 옵션 <br/> -f dockerfilename

<li>Dockerfile 경로 위치에서 실행</li>

```
$ docker build --tag gwlab/project .
```

> run
>
> 옵션 <br/> -v hostdir:containerdir <br/> --net=bridge<br/> --link mysql:mysql<br/> -p 8080:8080 <br/> --name mysql <br/> -e 환경변수

```
$ docker run -d --name project -p 8080:8080 gwlab/project
```

> container delete

```
$ docker rm -f project

# all delete
$ docker rm $(docker ps -a -q)
```

> images delete

```
$ docker rmi gwlab/project
or
$ docker rmi tagId

# all delete
$ docker rmi $(docker images -a -q)
```

> tar save and load

```
$ docker save -o gwee_influxdb.tar gwee/influxdb:latest

$ docker load < gwee_influxdb.tar
```

> file copy

```
$ docker cp container:path dest_path
```

> create

```
$ docker create --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD_FILE=/run/db_root_password -d mysql:5.7
```

> start

```
$ docker start mysql
```

### <li> docker network</li>

> network 정보 확인

```
$ docker network ls
```

> network 생성

```
$ docker network create \
--driver=bridge \
--subnet=172.28.0.0/16 \
--ip-range=172.28.5.0/24 \
--gateway=172.28.5.254 \
my-network
```

> network 삭제

```
$ docker network rm my-network
```

> docker 설정 정보 확인

```
$ docker inspect mysql

$ docker inspect -f "{{ .NetworkSettings.IPAddress }}" CONTAINER_ID
```

> docker host정보 확인

```
$ cat `sudo docker inspect -f "{{ .HostsPath }}" tomcat1`
```

> docker images 삭제

```
## 전체 이미지 삭제
$ docker rmi $(docker images -q)
## none 이지지만 삭제
$ docker images -q -f dangling=true
$ docker rmi $(docker images -f "dangling=true" -q)
```
