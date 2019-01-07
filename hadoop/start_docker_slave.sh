#!/bin/bash

echo "Deleting hadoop..."
docker rm -f hadoop_master

sleep 2

echo "Starting hadoop..."
docker run -d \
-p 50010:50010 -p 50020:50020 -p 50075:50075 \
--name hadoop_slave --hostname hadoop_slave gwess/centos7_hadoop_datanode
sleep 2

echo "Running hdfs..."
docker exec -it hadoop_slave bash -c '$HADOOP_PREFIX/bin/hdfs namenode -format && $HADOOP_PREFIX/sbin/start-dfs.sh'
