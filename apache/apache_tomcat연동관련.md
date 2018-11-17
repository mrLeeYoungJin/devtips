docker 기반 apache2.4 + tomcat8.5 연동
======================================

#### workers.properties 관련

```
atom 에디터에서 workers.properties 파일을 수정하여 서버로 업로드 시 텍스트 또는 인코딩 문제로 내용이 제대로 전달 안됨
예) atom에서 port를 아무리 수정해도 서버로 업로드 시 기본포트(8009로만 됨)
```

#### tomcat server.xml 문제

```
worker.jvm1.host=tomcat1

위의 tomcat1 호스트 정보를 server.xml의 <Engine name="Catalina" defaultHost="tomcat1" jvmRoute="jvm1">로 해줘야 함
```

#### tomcat 실행 시 java 옵션 넣기

```
-e JAVA_OPTS="-DjvmRoute=jvm1 -Dhostname=tomcat1"
```

###
