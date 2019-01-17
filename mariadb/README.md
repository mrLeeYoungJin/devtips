mysql
=====

-	refer site :

> http://

#### 명령어

> index 정보 보기

```
$ SHOW INDEXES FROM tablename;
```

> databases 별 용량 확인

```
$ SELECT table_schema, SUM((data_length+index_length)/1024/1024) MB FROM information_schema.tables GROUP BY 1;

```

> 전체 용량

```
$ SELECT SUM(data_length+index_length)/1024/1024 used_MB, SUM(data_free)/1024/1024 free_MB FROM information_schema.tables;

```

> tables별 용량

```
$ SELECT  \
    table_name, \
    table_rows, \
    round(data_length/(1024*1024),2) as 'DATA_SIZE(MB)', \
    round(index_length/(1024*1024),2) as 'INDEX_SIZE(MB)' \
FROM information_schema.TABLES \
where table_schema = 'pmsdb' \
GROUP BY table_name  \
ORDER BY data_length DESC;

```

> 서버의서의 database 용량

```
$ du -sh /var/lib/mysql
$ du -h /var/lib/mysql

```

> 테이블 정보 확인

```
$ show table status where name = 'T_PCS_ANALOG_VALUE';
$ select table_schema,table_name,engine from information_schema.tables

```

> 파티션 정보 확인

```
$ SELECT TABLE_SCHEMA, TABLE_NAME, PARTITION_NAME, PARTITION_ORDINAL_POSITION, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME =  'tablename';

```

> 특정 파티션 의 총 로우 확인

```
$ SELECT count(*) FROM tablename PARTITION (paritionname);

```

> 월별 파티션 생성 (기존 테이블 있을 경우) - 컬럼은 'TimeStamp' <br /> https://dev.mysql.com/doc/refman/5.7/en/partitioning-subpartitions.html

```
$ ALTER TABLE table1 PARTITION BY RANGE (TO_DAYS(TimeStamp)) (
PARTITION p_2017_01 VALUES LESS THAN (TO_DAYS('2017-02-01'))
  ENGINE = INNODB,
PARTITION p_2017_02 VALUES LESS THAN (TO_DAYS('2017-03-01'))
  ENGINE = INNODB,
PARTITION p_2017_03 VALUES LESS THAN (TO_DAYS('2017-04-01'))
  ENGINE = INNODB,
PARTITION p_2017_04 VALUES LESS THAN (TO_DAYS('2017-05-01'))
  ENGINE = INNODB,
PARTITION pmax VALUES LESS THAN MAXVALUE
  ENGINE = INNODB
);
```

> 파티션 삭제(data까지 삭제 됨)

```
$ ALTER TABLE table1 DROP PARTITION pmax;

```

#### db dump 및 backup

-	참고사이트 : https://www.lesstif.com/pages/viewpage.action?pageId=17105804

> 모든 db 백업(프로시져 / 함수 포함)

```
$ mysqldump --single-transaction –-routines --all-databases -h localhost -u root -pmypwd > mydump.sql

```

> 특정 db만 백업

```
$ mysqldump  --single-transaction --databases db1 -h localhost -u root -pmypwd > mydump.sql

```

> 특정 db만 백업하고 create 구분 미포함

```
$ mysqldump  --single-transaction db1  --no-create-db -h localhost -u root -pmypwd > mydump.sql

```

> 특정 table 만 덤프

```
$ mysqldump --single-transaction db1 table1 -h localhost -u root -pmypwd > mydump.sql

```

> db1만 포함하고 db내 table1, table2만 제외

```
$ mysqldump  --single-transaction --databases db1 --ignore-table=db1.table1  --ignore-table=db1.table2 -h localhost -u root -pmypwd > mydump.sql

```

> 특정 조건으로 데이타 덤프

```
$ mysqldump  --single-transaction --databases db1 --ignore-table=db1.table1  --ignore-table=db1.table2 -h localhost \
-u root -pmypwd \
--where='id>10000'
> mydump.sql
```
