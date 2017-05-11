# springboot + jsp 로 springMVC만들기

docker기반으로 springboot+jsp로 webservice 작업하면서 local에서는 eclise로 spring-boot:run(당연 maven project)로 실행하면
별다른 어려움없이 서비스 실행됨(embed tomcat사용)

```
문제
ubuntu 서버로 옮기면서  maven이 설치 없이 상태로 프로젝트를 jar로 압축하여 시 jsp파일이 포함되지 않아 view실행 불가
인터넷 검색 결과 resource/METE-INF/resource/WEB-INF 밑에 넣으면 된다고 해서 해봤는데 안됨...
```

```
해결
springboot 1.4.2 이하에서는 위의 방법대로 해결하면 됨..
1.4.3 이상은 war로 만들어서 외부 tomcat을 사용해서 실행해야 한다. 
```

```
기타
springboot + jsp의 조합은 일단 spring에서도 추천하지 않는다...만약 다시 개발하게 된다면 Thymeleaf,velocity를 사용하는게 나을듯...
물론 Template engines의 성능도 고려해야한다.
```