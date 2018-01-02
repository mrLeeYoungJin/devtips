docker 명령어
=============

build
-----

### Dockerfile 경로 위치에서 실행

```
docker build --tag gwlab/project .
```

> 옵션 <br/> -f dockerfilename

run

```
docker run -d --name project -p 8080:8080 gwlab/project
```

> 옵션 <br/> -v hostdir:containerdir <br/>

container delete
----------------

```
docker rm -f project
```

images delete
-------------

```
docker rmi gwlab/project
or
docker rmi tagId
```

tar save and import
-------------------

```
docker save -o gwee_influxdb.tar gwee/influxdb:latest

docker load < gwee_influxdb.tar
```
