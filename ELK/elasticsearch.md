elasticsearch 관련
==================

-	https://www.elastic.co
-	web port : 9200

#### index 확인

```
http://192.168.202.41:9200/_cat/indices?v
```

#### docker-cluster

-	https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_inspect_status_of_cluster

> 클러스터 상태 확인

```
$ curl http://127.0.0.1:9200/_cat/health
```

#### 조회 query

-	https://www.elastic.co/guide/en/elasticsearch/reference/current

> 단일 조건 쿼리 조회

```
##### request boby search
GET filebeat-6.6.2/_search
{
  "query": {
    "term" : { "date" : "20190322233013" }
  }
}

##### curl
curl -X GET "localhost:9200/filebeat-6.6.2/_search" -H 'Content-Type: application/json' -d' { "query" : { "term" : { "date" : "20190322233013" } } } '

```

> 단일 조건 like 쿼리 조회

```
GET filebeat-6.6.2/_search
{
  "query": {
    "wildcard" : { "date" : "2019032118*" }
  }
}
```

> and 조건 쿼리 조회

```
GET filebeat-6.6.2/_search
{
  "query": {
    "bool": {
      "must": [
        { "match": { "date": "20190321233013" } },
        { "match": { "subject": "gitlab_backup" } }
      ]
    }
  }
}
```

> timestamp 쿼리 조회

```
GET filebeat-6.6.2/_search
{
  "query": {
    "range": {
      "@timestamp": {
        "lte": "2019-03-22T00:00:00",
        "gte": "2019-03-21T21:00:00"
      }
    }
  }
}
```

> 조건 : 사이즈 2, timestamp로 내림차순, 특정 필드 항목, 날짜 검색 조건 쿼리

```
GET filebeat-6.6.2/_search
{
  "size": 2,
  "sort": [
    {
      "@timestamp": {
        "order": "desc",
        "unmapped_type": "boolean"
      }
    }
  ],
  "_source": ["@timestamp", "date", "subject", "success", "result_code", "filename", "message"],
  "query": {
    "range": {
      "@timestamp": {
        "gte": "2019-03-22T00:00:00"
      }
    }
  }
}

```

#### 삭제 query

> 단일 조회 삭제 쿼리

```
POST filebeat-6.6.2/_delete_by_query
{
  "query": {
    "term" : { "date" : "20190322233013" }
  }
}
```

> 단일 like 쿼리 삭제

1.	https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete-by-query.html

```
POST filebeat-6.6.2/_delete_by_query
{
  "query": {
    "wildcard" : { "date" : "2019032118*" }
  }
}
```

> and 조건 쿼리 삭제

1.	https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-range-query.html

```
POST filebeat-6.6.2/_delete_by_query
{
  "query": {
    "bool": {
      "must": [
        { "match": { "date": "20190321233013" } },
        { "match": { "subject": "test" } }
      ]
    }
  }
}
```

> timestamp 쿼리 삭제

-	많은 수의 쿼리 삭제 시 순차적으로 삭제가 진행된다.

```
POST filebeat-6.6.2/_delete_by_query
{
  "query": {
    "range": {
      "@timestamp": {
        "lte": "2019-03-22T00:00:00",
        "gte": "2019-03-21T21:00:00"
      }
    }
  }
}
```
