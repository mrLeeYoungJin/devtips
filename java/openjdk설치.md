OpenJDK 12 설치
==================

> openjdk site
- https://openjdk.java.net

> download
-	https://jdk.java.net/12

#### 시스템 OS에 맞게 다운로드

> 예) Windows 용 : https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_windows-x64_bin.zip

#### 압축해제 및 폴더 이동
- C:\Program Files\Java

#### 시스템 환경 변수 등록
-	시스템 변수에 등록
- 변수명 : JAVA_HOME
- 값 : C:\Program Files\Java\jdk-12.0.1

#### 확인

```
$ echo $JAVA_HOME
$ javac -version
```
