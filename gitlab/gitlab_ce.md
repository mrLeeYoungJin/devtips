ubuntu gitlab_ce 설치 및 사용법
===============================

#### gitlab_ce 설치

```
$ sudo apt-get install curl openssh-server ca-certificates postfix
## postfix는 일단 그냥 No Configuration으로 선택
## sudo dpkg-reconfigure postfix 명령으로 언제든지 설정 가능
$ curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

$ sudo apt-get install gitlab-ce

$ sudo gitlab-ctl reconfigure
## 설정파일 수정 후에는 항상 이 명령을 수행

$ gitlab-ctl -help
## gitlab-ctl 명령뒤에 사용할 수 있는 옵션(start..stop..upgrade 등등) 확인

$ sudo gitlab-ctl upgrade
## 그냥 한번 해 보았습니다. 이상하게 동작하면 restart하라는 메세지가 보입니다.
```

> 설치가 되고 나면 /etc/gitlab/ 디렉토리에 설정관련 파일(gitlaba.rb)이 /var/opt/gitlab 디렉토리에 gitlab을 구성하는 프로그램 파일과 설정 파일들이, /opt/gitlab/embedded/service/gitlab-rails/app/views 디렉토리에 프론트-엔드 부분 커스터마이징가능

#### 설정 및 적용

```
$ sudo gitlab-ctl reconfigure
$ sudo gitlab-ctl restart
$ sudo gitlab-ctl status
```

#### 삭제

```
$ sudo gitlab-ctl stop
$ sudo gitlab-ctl uninstall

&

$ sudo gitlab-ctl stop
$ sudo apt-get autoremove gitlab-ce
```
