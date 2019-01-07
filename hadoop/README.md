hadoop 설치 (docker 기반)
=========================

-	refer site :

> http://hadoop.apache.org <br /> https://github.com/sequenceiq/hadoop-docker <br /> https://bitbucket.org/uhopper/hadoop-docker <br /> https://github.com/CentOS/CentOS-Dockerfiles/tree/master/ssh/centos7

#### centos7 기반 hadoop 설치

> hadoop 관련 images builds

```
$ ./builds.sh
```

#### RUN

```
$ ./start_docker.sh
```

### 기타.

#### openjdk java 경로 확인

```
$ which java
$ readlink -f /usr/bin/java
```

#### hadoop fs 명령어

> 디렉토리 보기 <br /> /user 디렉토리가 기본 경로 <br /> root 계정일 경우 /user/root

```
$ hadoop fs -ls /user/root
```

> 디렉토리 생성

```
$ hadoop fs -mkdir -p /user/root/tempdir
```

> 파일만 생성

```
$ hadoop fs -touchz /user/root/tempdir/tempfile
```

> 파일 삭제

```
```

$ hadoop fs -rm /user/root/tempdir/tempfile

> 파일 복사

```
$ hadoop fs -put localfile /user/root/tempdir/copyfile
```

### 이슈

1.	hostname 설정

> clsuter로 설정 시 hostname에 "_"를 넣으면 "java.lang.IllegalArgumentException: Does not contain a valid host:port authority: " 오류 발생
