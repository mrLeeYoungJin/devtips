docker로 base_jupyter 실행(https://hub.docker.com/r/jupyter/base-notebook/\)
============================================================================

---

step1 (influxdb 실행)
---------------------

1.	docker run

	```
	> docker run -d -p 8888:8888 --restart=always --name notebook -v /var/data/notebook:/home/jovyan/work jupyter/base-notebook
	```
