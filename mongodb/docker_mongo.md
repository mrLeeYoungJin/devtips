docker로 mongodb replica set(auth 포함)
=======================================

---

replica set은 최소 3대 운용 필요
--------------------------------

### server : primary, secondary1, secondary2

> 서버가 2대일 경우 secondary2서버를 arbiters로 설정하여 replica set 투표 권한만 부여한다 (arbiters는 secondary 서버에 설정)

---

step1 (primary 생성)
--------------------

1.	create-replica-host.sh 실행

	```
	> ./create-replica-host.sh primary mongo /var/data/mongo
	```

step2 (secondary 생성)
----------------------

1.	create-replica-host.sh 실행하여 seondary 생성

	```
	> ./create-replica-host.sh secondary mongo_s1 /var/data/mongo_s1
	```

step3 (arbiters 생성)
---------------------

1.	create-replica-host.sh 수정하여 mongo port 변경(secondary와 충돌 방지)

	```
	> vi create-replica-host.sh
	```

2.	create-replica-host.sh 실행하여 arbiters 생성

	```
	> ./create-replica-host.sh secondary mongo_arb /var/data/mongo_arb
	```

3.	replication 상태 확인

	```
	> rs.status()
	```

step4(replica 설정)
-------------------

1.	primary server에서 mongo login

	```
	> docker exec -it mongo bash -c 'mongo -u user -p pwd  --authenticationDatabase="admin"'
	```

2.	secondary 추가

	```
	> rs.add("{secondary IP}:27018")
	```

3.	arbiters 추가

	```
	> rs.addArb("{arbiters IP}:27018")
	```
