#Virtual Memory sysctl -w vm.max_map_count=262144

elk docker run
==============

5601 (Kibana web interface).
============================

9200 (Elasticsearch JSON interface).
====================================

5044 (Logstash Beats interface, receives logs from Beats such as Filebeat ? see the Forwarding logs with Filebeat section).
===========================================================================================================================

docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it -d --name elk lyjguy/elk

index list search
=================

http://192.168.1.7:9200/_cat/indices?v

target index search
===================

http://192.168.1.7:9200/.kibana?pretty http://192.168.1.7:9200/filebeat-2017.11.10?pretty

data search (ex: /index/type/id?pretty)
=======================================

http://192.168.1.7:9200/.kibana/index-pattern/AV-fv5VVPB6sXaFMD05H?pretty

elk docker build
================

docker build --tag lyjguy/elk .

elk docker run
==============

docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it -d --name elk lyjguy/elk

filebeat test
=============

Build with:
===========

docker build -t lyjguy/nginx-filebeat .

Run with:
=========

docker run -p 81:80 -it --link elk:elk -d --name nginx-filebeat lyjguy/nginx-filebeat

curl -XPUT 'http://192.168.1.7:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json

filebeat 연결
=============

http://elk:9200/_template/filebeat?pretty

Elasticsearch status 정보
=========================

http://192.168.1.7:9200/_nodes/stats?pretty

Elasticsearch index 정보 보기
=============================

http://192.168.1.7:9200/filebeat-2017.11.13?pretty

Elasticsearch 명령어
====================

https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html

index create
============

curl -XPUT http:///192.168.1.7:9000/temp_idx

index delete
============

curl -XDELETE http:///192.168.1.7:9000/temp_idx

mapping create
==============

curl -XPUT 'http:///192.168.1.7:9000/temp_idx/tablename/_mapping' -d @mapping.json

mapping.json
============

PUT corning1_cbl_data/cbldata/_mapping { "properties": { "ResoId": { "type": "text" }, "CblType": { "type": "text" }, "CblDateTime": { "type": "date", "format": "yyyy-MM-dd HH:mm:ss||epoch_millis" }, "CblVal": { "type": "float" }, "ReduceCblVal": { "type": "float" }, "MeterVal": { "type": "float" }, "ReduceMeterVal": { "type": "float" } } }

csv import
==========

logstatsh conf
==============

input { file { path => "/home/timo/bitcoin-data/*.csv" start_position => "beginning" sincedb_path => "/dev/null" } } filter { csv { separator => "," columns => ["ResoId","CblType","CblDateTime","CblVal","ReduceCblVal","MeterVal", "ReduceMeterVal"] } } output { elasticsearch { hosts => "http://localhost:9200" index => "corning1_cbl_data" } stdout {} }

logstash conf 실행
==================

/opt/logstash/bin/logstash -f corning1_logstash.conf

search date range. Query DSL
============================

\{ "query": { "range": { "CblDateTime": { "gte": "2017-10-01 02:00:00", "lte": "2017-10-03 02:00:00", "format": "yyyy-MM-dd HH:mm:ss||epoch_millis" } } } }

search date weekend
===================

https://www.elastic.co/guide/en/elasticsearch/reference/master/modules-scripting-expression.html
================================================================================================

\{ "query": { "bool": { "filter": { "script": { "script": "doc['CblDateTime'].date.dayOfWeek == 1 || Doc['cbldatetime'].Date.Dayofweek == 2" } } } } }

filebeat log
============

tail -f -n 200 /var/log/filebeat/filebeat

#logstash pattern RECOM*DATE_TIME (\d{4}+\-\d{2}+\-\d{2} \d{2}+:\+\d{2}+:\+\d{2}+\,+\d{3}) THREAD_NAME (\[[a-zA-Z][a-zA-Z0-9_.+-=:]+]) LOG_LEVEL (\b\w+\b) FILE_PATH ([a-zA-Z][a-zA-Z0-9*.+-=:]+\?) MSG*DESC (\b\w+\b \b\w+\b \b\w+\b) SET_POINT (\d{3}+.\d{3,}) BANK_UUID ([a-zA-Z][a-zA-Z0-9*.+-=:]+) BANK_NAME (Bank+ \d{1}) RECOM_LOG_DATA %{RECOM_DATE_TIME:recom_date_time}KST %{THREAD_NAME:thread_name} %{LOG_LEVEL:log_level} %{FILE_PATH} - %{MSG_DESC} - would have set setpoint to %{SET_POINT:set_point} for bank %{BANK_UUID} with name %{BANK_NAME:bank_name}

logstash filter
===============

filter { if [type] == "nginx-access" { grok { match => { "message" => "%{NGINXACCESS}" } } } else if [type] == "lyjguy-test" { grok { match => { "message" => "%{RECOM_LOG_DATA}" } } date { match => [ "recom_date_time", "YYYY-MM-dd HH:mm:ss,SSS" ] target => "recom_date_time" timezone => "Asia/Seoul" } mutate {convert => ["set_point", "float"]} } }

=============================================

echo '2017-11-08 03:10:00,541KST [pool-2-thread-2] INFO c.c.e.o.a.O.s.RecommendationCreator:? - Power saver disabled - would have set setpoint to 217.79300389243022 for bank fd55b5cb-4e13-4a1b-88fe-f353d043445e with name Bank 4' >> /var/log/lyjguy/test.log echo '2017-11-08 03:10:00,541KST [pool-2-thread-2] INFO c.c.e.o.a.O.s.RecommendationCreator:? - Power saver disabled - would have set setpoint to 217.79300389243022 for bank fd55b5cb-4e13-4a1b-88fe-f353d043445e with name Bank 4' >> /var/log/elk/nginx-filebeat/test.log echo '2017-11-08 03:10:00,139KST [pool-2-thread-2] WARN c.c.e.o.a.O.a.g.t.VoltageStatisticsPerBasis:? - Device KC-21/22-210BA-3 has unknown basis voltage' >> /var/log/lyjguy/test.log

grep -i "set setpoint to" RecommendationEngine.log2017-11-08-0.log >> test.log echo "2017-11-08 08:5:01,891KST [pool-2-thread-2] INFO c.c.e.o.a.O.s.RecommendationCreator:? - Power saver disabled - would have set setpoint to 214.3239778808998 for bank 275bdf11-deac-4af7-9e03-0eef943edbb0 with name Bank 1" >> /var/log/elk/nginx-filebeat/test.log
