scouter 설치
============

```
https://github.com/scouter-project/scouter
https://github.com/scouter-project/scouter/releases
```

```
참고
https://github.com/scouter-project/scouter/blob/master/scouter.document/use-case/Method-Profiling_kr.md
http://judo0179.tistory.com/26
https://dockers.readthedocs.io/ko/latest/chapter5.html
https://www.slideshare.net/ienvyou/scouter-jboss?qid=3edb2487-a88e-4517-bb80-a666f1966c8e&v=&b=&from_search=1
```

> ---

Server
------

```
start
/scouter/server/startup.sh
```

client
------

agent.host
----------

```
start

/scouter/agent.host/host.sh
```

agent.java
----------

```
scouter.conf

### scouter java agent configruation sample
obj_name=docker-direct_purchase_api
net_collector_ip=192.168.1.62
net_collector_udp_port=6100
net_collector_tcp_port=6100
#hook_method_patterns=sample.mybiz.*Biz.*,sample.service.*Service.*
#trace_http_client_ip_header_key=X-Forwarded-For
#profile_spring_controller_method_parameter_enabled=false
#hook_exception_class_patterns=my.exception.TypedException
#profile_fullstack_hooked_exception_enabled=true
#hook_exception_handler_method_patterns=my.AbstractAPIController.fallbackHandler,my.ApiExceptionLoggingFilter.handleNotFoundErrorResponse
#hook_exception_hanlder_exclude_class_patterns=exception.BizException

```

Dockerfile
----------

```
FROM gwlab/ubuntu.14.04-jdk8
VOLUME /tmp
ADD direct_purchase_api.jar app.jar
RUN sh -c 'touch /app.jar'
RUN mkdir -p /var/www/logs/DirectPurchaseAPI
RUN mkdir -p /scouter/agent.java/conf
ENTRYPOINT ["java", "-Xms2048m", "-Xmx2048m", "-javaagent:/scouter/agent.java/scouter.agent.jar", "-Dscouter.config=/scouter/agent.java/conf/scouter.conf", "-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

```

```
docker create --name DirectPurchaseAPI -p 8080:8080 gwlab/direct_purchase_api
docker cp /home/lyjguy/directpurchaseapi/scouter/agent.java/scouter.agent.jar DirectPurchaseAPI:/scouter/agent.java/
docker cp /home/lyjguy/directpurchaseapi/scouter/agent.java/conf/scouter.conf DirectPurchaseAPI:/scouter/agent.java/conf/
```
