JPA 문제해결
==================


```
> 증상
SQL Error: 0, SQLState: S1009
Zero date value prohibited

> 원인
mysql datetime 형식에 0000-00-00 00:00:00 의 값이 들어가면 생기는 오류

> 해결
jdbc 프로퍼티 zeroDateTimeBehavior=convertToNull 추가

```

