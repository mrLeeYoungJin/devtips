docker-compose로 elk한번에 설치
===============================

-	https://github.com/deviantony/docker-elk/
-	https://www.elastic.co/guide/en/logstash/current/plugins-inputs-beats.html
-	https://www.elastic.co/guide/en/logstash/current/plugins-inputs-beats.html#plugins-inputs-beats-versioned-indexes

#### docker-compose 설치

-	아래 사이트 참고
-	https://docs.docker.com/compose/install/

#### docker-compose용 elk 실행

> 소스 다운로드

```
$ git clone https://github.com/deviantony/docker-elk.git
```

> docker-compose 빌드

```
$ docker-compose build
```

> docker-compose 실행

```
$ docker-compose up -d
```

> docker-compose 실행 확인

```
$ docker-compose ps
```

> docker-compose 실행 로그 확인

```
$ docker-compose logs -f
```
