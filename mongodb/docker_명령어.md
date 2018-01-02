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

1.	docker-compose를 이용하여 server를 실행 docker-compose up -d

	```
	> docker-compose up -d
	# vi docker-compose.yml
	version: '2.0'
	services:
	  mongo:  
	    restart: unless-stopped
	    image: mongo
	    ports:
	      - 27017:27017
	    volumes:  
	      - /var/data/mongo:/data
	    container_name: mongo  
	    command: mongod -f /data/conf/mongod.conf  
	```

2.	root 사용자 or 사용자 관리자 권한 생성

	```
	> mongo
	> use admin
	db.createUser({user: "user", pwd: "pwd", roles: [{role: "root", db: "admin"}]})
	db.createUser({user: 'user', pwd: 'pwd', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })
	```

3.	keyfile 생성([참고](https://docs.mongodb.com/manual/tutorial/deploy-replica-set-with-keyfile-access-control/)\)

	```
	> openssl rand -base64 756 > /data/keyfile/mongo-keyfile
	> chmod 400 /data/keyfile/mongo-keyfile
	> chwon -R mongodb:mongodb /data
	```

4.	docker 삭제(volume이 유지되어 기존 정보 있음)

	```
	docker rm -f mongo
	```

5.	keyfile secondary 서버에 복사(동일 권한 생성)

6.	mongod.conf 수정

	```
	> vi /var/data/mongo/conf/mongod.conf
	security:
	  authorization: enabled
	  keyFile: /data/keyfile/mongo-keyfile
	replication:
	  oplogSizeMB: 2048 #복제가 실패했을 경우 로그를 저장
	  replSetName: "rs1"
	```

step2 (secondary, arbiters 생성)
--------------------------------

1.	docker-compose를 이용하여 server를 실행

	```
	> docker-compose up -d

	# vi docker-compose.yml
	version: '2.0'
	services:
	mongo_s1:
	  restart: unless-stopped
	  image: gwee/mongo
	  ports:
	    - 27017:27017
	  volumes:
	    - /var/data/mongo_s1:/data
	  container_name: mongo_s1
	  command: mongod -f /data/conf/mongod.conf
	mongo_arb:
	  restart: unless-stopped
	  image: gwee/mongo
	  ports:
	    - 27018:27017
	  volumes:
	    - /var/data/mongo_arb:/data
	  container_name: mongo_arb
	  command: mongod -f /data/conf/mongod.conf
	```

2.	root 사용자 or 사용자 관리자 권한 생성

	```
	> mongo
	> use admin
	db.createUser({user: "user", pwd: "pwd", roles: [{role: "root", db: "admin"}]})
	db.createUser({user: 'user', pwd: 'pwd', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })
	```

3.	primary에서 생성한 keyfile의 복사 후 권한 추가

4.	docker 삭제(volume이 유지되어 기존 정보 있음)

	```
	docker rm -f mongo_s1 mongo_arb
	```

5.	mongod.conf 수정(primary와 동일)

	```
	> vi /var/data/mongo_s1/conf/mongod.conf
	> vi /var/data/mongo_arb/conf/mongod.conf
	security:
	  authorization: enabled
	  keyFile: /data/keyfile/mongo-keyfile
	replication:
	  oplogSizeMB: 2048 #복제가 실패했을 경우 로그를 저장
	  replSetName: "rs1"
	```

6.	docker-compose 재시작

	```
	docker-compose up -d
	```

step3(replica 설정)
-------------------

1.	primary server에서 mongo login

	```
	> docker exec -it mongo sh
	> mongo -u "user" -p "pwd"  "admin" --authenticationDatabase "admin"
	> config = {
	    "_id" : "rs1",
	    "members" : [
	        { "_id" : 0, "host" : "{primary IP}:27017" },
	        { "_id" : 1, "host" : "{secondary IP}8:27017" }
	    ]
	  }
	> rs.initiate(config)  
	> rs.addArb("{arbiters IP}:27018") # arbitest 추가
	> rs.status() # replica set 설정 확인
	```

step4 (공유 db 생성 및 데이터 확인)
-----------------------------------

1.	primary server login후 데이터 생성

	```
	> docker exec -it mongo sh
	> mongo -u "user" -p "pwd"  "admin" --authenticationDatabase "admin"
	> use userdb
	> db.createUser({ user: "user", pwd: "pwd", roles: [ { role: "readWrite", db: "userdb" } ] });
	> db.testcollection.insert({ "data": "test"});
	```

2.	sercondary server login후 데이터 확인

	```
	> docker exec -it mongo_s1 sh
	> mongo -u "user" -p "pwd" "pwd" "userdb"
	> rs.slaveOk()
	> db.testcollection.find({});
	```

	> arbiters 서버는 데이터 생성은 하지 않는다.

step5 (heartbeat 동작 확인)
---------------------------

1.	primary server 중지

	```
	> docker stop mongo
	```

2.	secondary server 확인

	```
	> docker exec -it mongo_s1 sh
	> mongo -u "user" -p "pwd"  "admin" --authenticationDatabase "admin"
	> rs.status()
	```
