docker로 influxdb 실행(https://docs.influxdata.com\)
====================================================

-	refer site :

> user : https://docs.influxdata.com/influxdb/v0.9/administration/authentication_and_authorization/#admin-users

### influxdb 실행

1.	docker run

	```
	> docker-compose up -d
	```

2.	influxdb propt

	```
	> influx -precision rfc3339
	```

### attach

```
docker exec -it influxdb sh -c 'influx -precision rfc3339' docker exec -it influxdb sh -c 'influx -precision rfc3339 -database corning -username admin -password admin12#$'
```

### login

```
$ auth admin admin12#$
$ database
```

### query

1.	show

```
$ SHOW DATABASES USE corning_ss2

$ show measurements

$ SHOW SERIES ON testdb SHOW TAG KEYS ON "testdb" SHOW STATS SHOW DIAGNOSTICS.

$ SHOW TAG KEYS ON "corning"

$ SHOW CONTINUOUS QUERIES
```

1.	create

```
$ CREATE RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> [SHARD DURATION <duration>] [DEFAULT] ALTER RETENTION POLICY autogen ON testdb REPLICATION 1 use testdb SHOW RETENTION POLICIES ON testdb
```

1.	select

```
$ select DISTINCT(device) from ss2

$ SHOW TAG KEYS ON "corning_ss2" from "voltage" show series on corning_ss2 from $ "voltage" SHOW TAG VALUES ON "corning_ss2" WITH KEY = "value" SHOW FIELD KEYS ON "corning_ss2" from "voltage"

$ drop MEASUREMENT "voltage2"
```

1.	delete

```
$ delete from reso_va DROP MEASUREMENT "h2o_feet"

$ DROP CONTINUOUS QUERY cq_basic2 ON corning

$ DROP MEASUREMENT "average_passengers"
```
