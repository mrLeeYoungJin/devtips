docker 기반 redmine 설치
========================

```
https://hub.docker.com/_/redmine/
```

```
참고
https://jistol.github.io/its/2018/01/25/redmine-mysql-in-docker/
```

---

docker-compose 파일 작성
------------------------

```
redmine.yml

# docker-compose 로 생성할경우 별도의 network bridge가 생성됨
# docker-compose -f redmine.yml up -d
version: '3.1'

services:
  redmine:
    image: redmine
    restart: always
    container_name: redmine
    ports:
      - 3000:3000
    volumes:
      - /data/redmine:/usr/src/redmine/files
    environment:
      REDMINE_DB_MYSQL: db
      REDMINE_DB_PASSWORD: redmine
      REDMINE_DB_DATABASE: redmine
      REDMINE_DB_ENCODING: utf8
#     REDMINE_NO_DB_MIGRATE: true
  db:
    image: mysql:5.7
    restart: always
    container_name: mysql
    ports:
      - 3306:3306
    volumes:
      -  /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: redmine
      MYSQL_DATABASE: redmine
    command:
      - --character-set-server=utf8mb4
      - --collation-server=utf8mb4_unicode_ci
```

docker-compose 실행(docker-compose 설치 해야함)

```
docker-compose -f redmine.yml up -d
```

> date 설정

```
$ TZ=Asia/Seoul
$ ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
```

browser 접속
------------

```
http://localhost:3000
```

\* redmine plugin 설치
----------------------

```
docker 접속
$ docker exec -it redmine sh
$ docker:redmine$ apt-get update
$ docker:redmine$ apt-get install -y unzip vim

## Issue Template Plugin
docker:redmine$ cd /usr/src/redmine
docker:redmine$ git clone https://github.com/akiko-pusu/redmine_issue_templates.git plugins/redmine_issue_templates
docker:redmine$ rake redmine:plugins:migrate RAILS_ENV=production
$ docker restart redmine

## 테마 변경
https://www.redmineup.com/pages/themes/circle 에서 다운로드

docker cp redmine_bak/public/themes/circle_theme-3_0_0.zip redmine:/usr/src/redmine/public/themes
cd /public/themes
unzip circle_theme-3_0_0.zip
$ docker restart redmine

## slack 연동(https://damduck01.com/310)
docker:redmine$ git clone https://github.com/sciyoshi/redmine-slack plugins/redmine_slack
docker:redmine$ gem install httpclient
docker:redmine$ rake redmine:plugins:migrate RAILS_ENV=production
$ docker restart redmine

## redmine_startpage
docker:redmine$ git clone https://github.com/gatATAC/redmine_startpage.git plugins/redmine_startpage
docker:redmine$ rake redmine:plugins:migrate RAILS_ENV=production
$ docker restart redmine

## progressive-projects-list-list.git
docker:redmine$ git clone https://github.com/stgeneral/redmine-progressive-projects-list.git plugins/progressive_projects_list
docker:redmine$ rake redmine:plugins:migrate RAILS_ENV=production
$ docker restart redmine

## redmine_ganttproject_sync.git
docker:redmine$ git clone https://github.com/milgner/redmine_ganttproject_sync.git plugins/redmine_ganttproject_sync
docker:redmine$ rake redmine:plugins:migrate RAILS_ENV=production
$ docker restart redmine

## redmine_gitlab_hook
## https://github.com/phlegx/redmine_gitlab_hook
docker:redmine$ git clone https://github.com/phlegx/redmine_gitlab_hook.git plugins/redmine_gitlab_hook
docker:redmine$ rake redmine:plugins:migrate RAILS_ENV=production
$ docker restart redmine

## uninstall rake
docker:redmine$ rake redmine:plugins:migrate NAME=redmine_ganttproject_sync VERSION=0 RAILS_ENV=production
$ docker restart redmine
```
