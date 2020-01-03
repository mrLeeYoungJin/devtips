redis 관련
==================

> redis site
- https://redis.io/


#### redis client 명령어

> client 연결

```
$ redis-cli -h redis.client.domain.com -p 6379
```

> count

```
## 실제 서비스에서는 성능상 좋지 않기 때문에 
$ keys *
```

> 특정 key 조회

```
$ keys custom_id
```
