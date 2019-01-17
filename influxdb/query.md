### query

attach
------

docker exec -it influxdb sh -c 'influx -precision rfc3339' docker exec -it influxdb sh -c 'influx -precision rfc3339 -database corning -username admin -password admin12#$'

user : https://docs.influxdata.com/influxdb/v0.9/administration/authentication_and_authorization/#admin-users
-------------------------------------------------------------------------------------------------------------

SHOW USERS

CREATE USER admin WITH PASSWORD admin12#$ WITH ALL PRIVILEGES

CREATE USER admin WITH PASSWORD 'admin12#$' WITH ALL PRIVILEGES SHOW GRANTS FOR admin GRANT ALL ON testdb TO admin

### login

auth admin admin12#$

database
--------

CREATE DATABASE "corning"

CREATE RETENTION POLICY <retention_policy_name> ON <database_name> DURATION <duration> REPLICATION <n> [SHARD DURATION <duration>] [DEFAULT] ALTER RETENTION POLICY autogen ON testdb REPLICATION 1 use testdb SHOW RETENTION POLICIES ON testdb

table
-----

SHOW measurements

info
----

SHOW SERIES ON testdb SHOW TAG KEYS ON "testdb" SHOW STATS SHOW DIAGNOSTICS.

SHOW TAG KEYS ON "corning"

insert
------

insert reso_va,tag_id=nb-154-211j-1 dt="2017-02-13 11:32:00.359000",val=220.0 1486953120000000000

insert reso_va,tag_id=nb-154-211j-1,dt="2017-02-13 11:33:00.359000" val=230.0 1486953180000000000

select
------

SELECT * FROM reso_va

delete
------

delete from reso_va DROP MEASUREMENT "h2o_feet"

### backup and restore

https://docs.influxdata.com/influxdb/v1.4/administration/backup_and_restore/#backing-up-the-metastore

curl -i -XPOST 'http://192.168.1.7:9096/write?db=corning' -u admin:admin12#$ --data-binary 'glass,host=server1,region=us-west value=2.64 1434055566000000000'

curl -i -XPOST 'http://192.168.1.7:8087/write?db=corning' -u admin:admin12#$ --data-binary 'glass,host=server1,region=us-west value=1.64 1434055565000000000'

docker exec -it influxdb sh -c 'influx -execute "CREATE DATABASE 'corning'"' docker exec -it influxdb sh -c 'influx -precision rfc3339 -database corning -execute "select * from glass ORDER BY time desc limit 1"'

docker exec -it influxdb sh -c 'influx -precision rfc3339 -database corning -execute "select * from glass ORDER BY time desc limit 1"'

influx -precision rfc3339 -database corning CREATE CONTINUOUS QUERY "cq_basic" ON "corning" RESAMPLE EVERY 10s BEGIN SELECT value, time INTO "average_passengers" FROM (select * from glass order by time desc limit 1) order by time desc END

CREATE CONTINUOUS QUERY "cq_basic2" ON "corning" RESAMPLE EVERY 10s BEGIN SELECT mean(value) INTO "average_passengers" FROM glass GROUP BY time(1m) END

SELECT mean(value), time INTO "average_passengers" FROM (select * from glass order by time desc limit 1) GROUP BY time(10s) order by time desc

SELECT value, time INTO "average_passengers" FROM (select * from glass order by time desc limit 1) order by time desc

select * from glass select * from average_passengers

continuous-query-management
---------------------------

https://docs.influxdata.com/influxdb/v1.4/query_language/continuous_queries/#continuous-query-management

SHOW CONTINUOUS QUERIES

### delete

DROP CONTINUOUS QUERY cq_basic2 ON corning

DROP MEASUREMENT "average_passengers"

SELECT value, time INTO corning.autogen.average_passengers FROM (SELECT * FROM corning.autogen.glass ORDER BY time DESC LIMIT 1) ORDER BY time DESC
