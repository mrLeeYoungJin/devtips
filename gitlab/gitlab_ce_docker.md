gitlab-ce 설치
==============

docker로 설치
-------------

-	run

```
docker run -d -p 80:80 --hostname 192.168.1.162 --restart always --name gitlab \
-v /var/data/gitlab/config:/etc/gitlab \
-v /var/data/gitlab/opt:/var/opt/gitlab  \
-v /var/data/gitlab/log:/var/log/gitlab  \
gitlab/gitlab-ce
```

> backups

```
$ docker exec -t gitlab gitlab-rake gitlab:backup:create
```

> date 설정

```
$ TZ=Asia/Seoul
$ ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
```

#### issues

> redmine 연동

```
내부 ip 및 사설 ip 연동 시 보안 문제
해결 : https://docs.gitlab.com/ee/security/webhooks.html
Settings > Network > Outbound requests 에서
Allow requests to the local network from hooks and services 항목 체크
```

### redmine 연동

> 참고 : http://demun.tistory.com/2431
>
> ssh-keygen 설정

```
1. 로컬 pc 에서 ssh-keygen 생성
# 모든 내용 그냥 엔터 처리
$ ssh-keygen

2. ~/.ssh/id_rsa.pub 파일 내용 복사

3. gitlab의 사용자 profile의 SSH Keys에서 복사한 공개키 등록

4. 로컬 PC 에서 gitlab 계정 등록
$ git config --global user.name 'redmine'
$ git config --global user.email 'redmine@gridwiz.com'

5. 로컬 pc에서 ssh로 연결
$ git clone git@url.github

ETC.
1. 기존 gitlab 서버의 ssh 포트가 22 이면 다른 포트로 변경 후 gitlab ssh 포트를 22르 설정
```

### redmine 에 crontab을 걸어서 저장소 주기적 업데이트

> docker 내에서는 crontab이 동작 하지 않는다.

```
# Git clone
# git clone --mirror  http://giturl.git


## host 서버에서 cronjob 실행
## 5분에 한번 저장소 sync
$ vi /etc/cron.d/redmine_sync_git_repos
*/5 * * * * root docker exec redmine source/sync_git_repos.sh
```

### sync_git_repos.sh

```
#!/bin/sh

cd /usr/src/redmine/source/testproject.git && git fetch -q --all -p
```
