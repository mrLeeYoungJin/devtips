docker-compose 명령어
=====================

---

#### Site

```
https://docs.docker.com/compose/install/

```

### 설치

```
$ sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose
```

시작

```
docker-compose up -d

```

> 특정 파일로 실행 <br/> docker-compose -f /path/filename.yml up -d

종료
----

```
docker-compose down

```

컨테이너 시작 (특정 컨테이너만)
-------------------------------

```
docker-compose start tomcat8

```

재시작할 컨테이너만 지정
------------------------

```
docker-compose up --no-deps -d tomcat nginx
```

예) docker-compose.yml
-----------------------

```
mariadb:
  restart: always
  image: mariadb
  ports:
   - "3406:3306"
  volumes:
   -  /var/lib/mysql:/var/lib/mysql
  container_name: mariadb
tomcat:
  restart: always
  image: gw/tomcat8
  ports:
   - "8080:8080"
  links:
   - mariadb:mariadb
  volumes:
   - /var/log/tomcat:/usr/local/tomcat/logs
   - /var/www/logs/:/var/www/logs
  container_name: tomcat
nginx:
  restart: always
  image: gw/nginx
  ports:
   - "82:80"
  links:
   - tomcat:tomcat
  volumes_from:
    - tomcat
  volumes:
   - /var/jenkins/workspace/SAMPLE_PROJECT/WebContent:/var/www/nginx
   - /var/log/nginx:/var/log/nginx
  container_name: nginx

```
