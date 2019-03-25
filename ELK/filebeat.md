docker로 filebeat 설치
======================

-	https://www.elastic.co/guide/en/beats/filebeat/index.html
-	https://www.elastic.co/guide/en/beats/filebeat/current/running-on-docker.html

#### filebeat 설치

> docker images 다운로드

```
$ docker pull docker.elastic.co/beats/filebeat:6.6.2
```

> filebeat.docker.yml 다운로드

```
$ curl -L -O https://raw.githubusercontent.com/elastic/beats/6.6/deploy/docker/filebeat.docker.yml
```

> filebeat.docker.yml 수정

1.	filebeat.docker.yml 참조하여 본인에 맞게 설정

```
$ vi filebeat.docker.yml
```

> docker running

```
$ docker run -d --name=filebeat --user=root  \
 --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
 --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
 --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
 --volume="/data/script/test.log:/var/log/gitlab.log:rw" \
 docker.elastic.co/beats/filebeat:6.6.2 filebeat -e -strict.perms=false
```

> docker-compose running

```
# filebeat_docker-compose.yml 파일 참조
```

> 실행 로그 확인

```
$ docker logs -f filebeat
```

#### logstash와 연동
