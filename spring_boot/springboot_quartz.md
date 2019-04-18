quartz with spring-boot
==================

> quartz
-	http://www.quartz-scheduler.org
-	https://github.com/quartz-scheduler/quartz

> spring-boot quartz
- https://docs.spring.io/spring-boot/docs/2.1.3.RELEASE/reference/html/boot-features-quartz.html
- https://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html
- https://github.com/spring-projects/spring-boot/tree/v2.1.4.RELEASE/spring-boot-project/spring-boot-autoconfigure/src/main/java/org/springframework/boot/autoconfigure/quartz

#### spring-boot 설정

> pom.xml 의존성 추가

```
  <dependency>
	 <groupId>org.springframework.boot</groupId>
	 <artifactId>spring-boot-starter-quartz</artifactId>
  </dependency>
```
> application.properties 기본 설정 정보 (시스템에 맞게 커스텀)

```
spring.quartz.auto-startup=true
spring.quartz.jdbc.comment-prefix=--
spring.quartz.jdbc.initialize-schema=embedded
spring.quartz.jdbc.schema=classpath:org/quartz/impl/jdbcjobstore/tables_@@platform@@.sql
spring.quartz.job-store-type=memory
spring.quartz.overwrite-existing-jobs=false
spring.quartz.properties.*=
spring.quartz.scheduler-name=quartzScheduler
spring.quartz.startup-delay=0s
spring.quartz.wait-for-jobs-to-complete-on-shutdown=false
```

> jboStoreType 을 jdbc로 할 경우 db 스키마 생성

- https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/resources/org/quartz/impl/jdbcjobstore
