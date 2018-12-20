centos7 명령어
==============

#### 패키지 업데이트

```
$ yum update
```

#### java 패키지 확인

```
$ yum list java*jdk-devel
```

#### openjdk 1.8 설치

```
$ yum install java-1.8.0-openjdk-devel.x86_64
```

#### openjdk 1.8 패키지 설치 확인

```
$ rpm -qa java*jdk-devel
```

#### ssh 서버 / 클라이언트 설치

```
$ yum install openssh-server openssh-clients openssh-askpass
```
