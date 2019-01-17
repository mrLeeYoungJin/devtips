ubuntu 명령어
=============

#### 저장소

> 저장소 변경

```
$ vi /etc/apt/sources.list
$ :%s/kr.archive.ubuntu.com/mirror.kakao.com/g
$ :%s/security.ubuntu.com/ftp.daum.net/g
$ :%s/extras.ubuntu.com/mirror.kakao.com/g
$ apt-get update
$ apt-get upgrade
```

> 저장소 추가

-	add-apt-repository 실행 시 command not found 경우 apt-get install software-properties-common 설치

```
# 저장소 목록을 추가
$ add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu dapper main restricted"
```
