# springboot + embed tomcat

============
```
문제
특정 maven lib 추가하여 spring-boot:run 실행 시 
java.lang.IllegalStateException: The Java Virtual Machine has not been configured to use the desired default character encoding (UTF-8).
오류 발생

```

```
해결
system properties encoding을 맞춰줘야 한다.(system file enconding이 MS949일 경우)
spring.mandatory-file-encoding=MS949
 
```
============