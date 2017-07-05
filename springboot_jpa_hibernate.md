# springboot + jpa + hibernate 로 spring api 만들기

```
refer site
http://docs.spring.io/spring-data/jpa/docs/1.9.6.RELEASE/reference/html/
http://adrenal.tistory.com/23
http://adrenal.tistory.com/25
http://www.querydsl.com
```

## version
```
spring boot : 1.5.4
```

============
```
문제
Entity(model)에 lombok을 적용하면 entity 자동 생성이 안됨
boot 버전 문제 인듯..(타 블로그에서는 jpa+lombok)
```

```
해결
일단 lombok을 사용 하지 않고 수동으로 get, set생성 
```
============

============
```
문제
Spring boot 와 spring data jpa 사용시 @Column(name="SITE_SEQ") 와 같이 camelcase 형태로 지정 했을 경우, name의 속성이 무시되고 underscore형태의 "stock_seq" 를 찾는 오류가 나타난다. 
```

```
해결
hibernate 4.x 
spring.jpa.hibernate.naming.implicit-strategy= # Hibernate 5 implicit naming strategy fully qualified name.
spring.jpa.hibernate.naming.physical-strategy= # Hibernate 5 physical naming strategy fully qualified name.
spring.jpa.hibernate.naming.strategy= # Hibernate 4 naming strategy fully qualified name. Not supported with Hibernate 5.

hibernate 5.x
spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
```
============

============
```
문제
jpa 양방향 설정시(onetomany, manytone) view dto에서 데이터 무한루프생성되는 문제 
```

```
해결
1. 아래json어노테이션을 이용하여 직렬화가 한번만 되도록 설정
@JsonIdentityInfo(generator=ObjectIdGenerators.IntSequenceGenerator.class, property="userSeq")
2. mapper bean 설정
@Bean
public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter() {
    MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.registerModule(new Hibernate5Module());
    objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    jsonConverter.setObjectMapper(objectMapper);
    return jsonConverter;
}

아니면 dto와 entity를 분리하여 관리.
http://www.baeldung.com/entity-to-and-from-dto-for-a-java-spring-application

refer
http://www.oraclejavanew.kr/bbs/board.php?bo_table=LecJpa&wr_id=274
```
============