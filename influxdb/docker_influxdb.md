docker로 nodered(https://nodered.org/\)
=======================================

---

step1 (node red 실행)
---------------------

1.	docker run

	```
	> docker run -d -p 1880:1880 -v /var/data/nodered:/data --name nodered nodered/node-red-docker
	```
