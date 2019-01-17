grafana with docker
===================

### docker run

```
docker run -d -p 3000:3000 --name=grafana -v /var/data/grafana:/var/lib/grafana grafana/grafana
```

### browser open

```
http://192.168.1.7:3000
```

> default id / password

```
admin / admin
```

### query

> chart query

```
SELECT UNIX_TIMESTAMP(date_format(FROM_UNIXTIME(utc_time_ms/1000), '%Y-%m-%d %T')) as time_sec, (voltage_statistics->>"$.min") as value, bank_uuid as metric FROM setpoint_prediction_input_history order by date_format(FROM_UNIXTIME(utc_time_ms/1000), '%Y-%m-%d %T') asc

```

> table query

```
SELECT date_format(FROM_UNIXTIME(utc_time_ms/1000), '%Y-%m-%d %T') as datetime, (voltage_statistics->>"$.min") as LowVol, bank_uuid as bank FROM setpoint_prediction_input_history order by utc_time_ms desc
```
