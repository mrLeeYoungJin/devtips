tomcat issue
========================

> 설치형 톰캣과 스프링부트 연동 시 오류는 나오지 않고 스프링부트 로깅이 안될때(클래스 패스를 찾지 못하는 듯)

```
SpringBoot main class 작성 시 SpringBootServletInitializer 클래스 상속하여 외부 톰캣을 의존 하도록 해야함 
```
