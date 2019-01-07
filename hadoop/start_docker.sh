#!/bin/bash

echo "Deleting hadoop..."
docker rm -f hadoop_master

sleep 2

echo "Starting hadoop..."
docker run -d \
-p 50010:50010 -p 50020:50020 \
-p 50070:50070 -p 50075:50075 \
-p 50090:50090 -p 50091:50091 -p 2122:2122 -p 8088:8088 -p 9000:9000 \
--name hadoop_master --hostname hadoop_master gwess/centos7_hadoop_namenode
#--name hadoop --hostname 192.168.202.41 gwess/centos7_hadoop_namenode
sleep 2

echo "Running hdfs..."
docker exec -it hadoop bash -c '$HADOOP_PREFIX/bin/hdfs namenode -format && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/sbin/start-yarn.sh'
