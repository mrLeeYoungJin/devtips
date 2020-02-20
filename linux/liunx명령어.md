Linux 명렁어(centos7)
=====================

#### 버전 확인

```
$ cat /etc/*-release | uniq
```

#### scp

> <옵션> <br /> -P 포트번호 <br /> -r 폴더 복사

<br />

> 원격에서 가져오기(복사)

```
$ scp -P 22 root@192.168.1.1:/var/data .
```

> 원격 내보내기(복사)

```
$ scp -P 22 test.txt root@192.168.1.1:/var/data
```

#### process

```
$ ps -eo user,pid,rss,time,cmd --sort -rss | head -n 5
```

#### network

```
$ yum install net-tools
```

#### filesize 확인

```
$ ls -alh
$ ls -alSh
```

#### 폴더별 용량 확인

```
$ du -sh /var
$ du -kh --max-depth=1
$ du -h --max-depth=1
```

#### 파일로그 보기

-	tail, head, cat, less, more

```
$ tail -f test.log
```

#### 압축

-	gzip

> 압축

```
$ gzip test.log
```

> 압축 해제

```
$ gzip -d test.log.gz
```
