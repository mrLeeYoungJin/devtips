docker로 splunk
===============

---

docker로 splunk 운용하기
------------------------

> ---

install
-------

1.	docker image pull

	```
	docker pull splunk/splunk:7.0.0
	```

2.	docker image pull

	```
	docker-compose up -d
	```

3.	localhost:8000 실행

	```
	http://localhost:8000
	```

	> password 변경 : admin / admin

dbx install
-----------

1.	splunk apps 에서 dbx install > install 시에 splunk 계정 필요

2.	java install(http://south10.tistory.com/entry/%EB%A6%AC%EB%88%85%EC%8A%A4-%EC%9A%B0%EB%B6%84%ED%88%AC-%EC%88%98%EB%8F%99%EC%9C%BC%EB%A1%9C-%EC%9E%90%EB%B0%94-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0\)

	```
	docker exec -it splunk sh
	cd /opt
	apt-get update
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz
	tar -zxvf jdk-8u151-linux-x64.tar.gz
	ln -s jdk1.8.0_151/ java
	vi /etc/profile
	source /etc/profile
	```

	> /etc/profile <br /> export JAVA_HOME=/opt/java export <br /> CLASSPATH=.:$JAVA_HOME/jre/lib/ext:$JAVA_HOME/lib/tools.jar <br /> PATH=$PATH:$JAVA_HOME/bin

3.	mysql-connector install(http://docs.splunk.com/Documentation/DBX/3.1.1/DeployDBX/Installdatabasedrivers#AWS_RDS_Aurora.2C_MemSQL.2C_or_MySQL\)

	```
	wget http://download.softagency.net/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz
	```

query sample
------------

1.	query sample

	```
	(index=* OR index=_*) (source=setpoint_prediction_input) (bank_uuid="*0eef943edbb0") | replace *0eef943edbb0 WITH B1LV, *4e8c05cb1d6e WITH B3LV, *61a077b5b251 WITH B2LV, *f353d043445e WITH B4LV IN bank_uuid | rename bank_uuid AS RootObject.bank_uuid datetime AS RootObject.datetime max AS RootObject.max min AS RootObject.min | eval "RootObject.bank_uuid"='RootObject.bank_uuid', _time='_time' | timechart dedup_splitvals=t limit=100 useother=t values(RootObject.max) AS max values(RootObject.min) AS min span=2m by RootObject.bank_uuid format=$VAL$:::$AGG$ | sort limit=0 _time | fields _time *
	```
