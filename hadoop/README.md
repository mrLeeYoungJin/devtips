hadoop 설치 (docker 기반)
=========================

-	refer site :

> https://github.com/sequenceiq/hadoop-docker <br /> https://bitbucket.org/uhopper/hadoop-docker <br /> https://github.com/CentOS/CentOS-Dockerfiles/tree/master/ssh/centos7

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
