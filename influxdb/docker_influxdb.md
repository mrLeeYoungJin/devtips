docker로 influxdb 실행(https://docs.influxdata.com\)
====================================================

---

step1 (influxdb 실행)
---------------------

1.	docker run

	```
	> docker-compose up -d
	```

2.	influxdb propt

	```
	> influx -precision rfc3339
	```

3.	query

	```
	SHOW DATABASES
	USE corning_ss2


	show measurements
	```

	```
	select DISTINCT(device) from ss2


	SHOW TAG KEYS ON "corning_ss2" from "voltage"
	show series on corning_ss2 from "voltage"
	SHOW TAG VALUES ON "corning_ss2" WITH KEY = "value"
	SHOW FIELD KEYS ON "corning_ss2" from "voltage"


	drop MEASUREMENT "voltage2"
	```
