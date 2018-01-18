docker로 influxdb HA구성
========================

---

물리적 2대의 서버에 influxdb 설치 후 influx-relay로 HA
------------------------------------------------------

### server 구성 : server1(node1, influx-relay), server2(node2)

> 사이트 : https://www.influxdata.com <br /> influx-relay 참고 사이트 : https://github.com/influxdata/influxdb-relay

step1 (node1 influxdb 생성)
---------------------------

1.	influxdb.conf 파일 추가(사용자 경로 지정)

	```
	> docker run --rm influxdb:1.4.2 influxd config > /var/data/influxdb/influxdb.conf
	```

2.	docker-compse.yml 생성

	```
	influxdb:
	  restart: unless-stopped
	  image: influxdb:1.4.2
	  ports:
	    - "8086:8086"
	  volumes:
	    - /var/data/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf:ro
	    - /var/data/influxdb/data:/var/lib/influxdb
	  container_name: influxdb
	  command: -config /etc/influxdb/influxdb.conf
	```

3.	docker-compse.yml 실행

	```
	> docker-compose up -d
	```

step2 (node2 influxdb 생성)
---------------------------

1.	node1과 동일하게 생성

step3 (influx-relay 생성)
-------------------------

1.	사용자 디렉토리 이동

	```
	> cd /home/lyjguy/influxdb-relay
	```

2.	influx-relay github 소스 다운로드(git은 미리 설치)

	```
	> git clone https://github.com/influxdata/influxdb-relay.git
	```

3.	dockerfile build

	```
	> docker build -f Dockerfile_build_ubuntu64 -t gwee/influxdb-relay-builder:1.0 .
	```

4.	relay build 파일 생성

	```
	> docker run --rm -v /home/lyjguy/influxdb-relay:/root/go/src/github.com/influxdata/influxdb-relay gwee/influxdb-relay-builder:1.0
	```

5.	relay.toml 파일 복사(생성 후 파일 내용 설정 변경)

	```
	> cp sample.toml build/relay.toml
	```

6.	influx-relay 실행

	```
	> ./influxdb-relay -config relay.toml
	```

step4 (test)
------------

1.	influx-relay port로 ha 테스트

	```
	> curl -i -XPOST 'http://localhost:9096/write?db=testdb' --data-binary 'glass,host=server13,region=us-west value=0.64 1434055562000000000'
	```

2.	node1, node2 influxdb 데이터 확인

docker run -d -p 1880:1880 -v /var/data/nodered:/data --name nodered nodered/node-red-docker
