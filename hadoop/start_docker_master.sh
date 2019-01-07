#!/bin/bash

echo "Deleting hadoop..."
docker rm -f hadoopmaster hadoopdatanode1 hadoopdatanode2

sleep 2

#echo "Starting hadoop namenode secondary..."
#docker run -d \
#-p 50090:50090 \
#-p 50010:50010 -p 50020:50020 -p 50075:50075 \
#--name hadoop_slave --hostname hadoopslave gwess/centos7_hadoop_namenode

#sleep 2

echo "Starting hadoop namenode master..."
docker run -d \
-p 50070:50070 \
-p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8088:8088 \
-p 2122:2122 -p 9000:9000 \
--name hadoopmaster --hostname hadoopmaster gwess/centos7_hadoop_namenode
sleep 2

#echo "Starting hadoop datanode1..."
docker run -d \
-p 50010:50010 -p 50020:50020 -p 50075:50075 \
-p 8042:8042 -p 8044:8044 \
--name hadoopdatanode1 --hostname hadoopdatanode1 --link hadoopmaster:hadoopmaster gwess/centos7_hadoop_datanode
sleep 2

#echo "Starting hadoop datanode2..."
docker run -d \
-p 50010 -p 50020 -p 50075 \
-p 8042 -p 8044 \
--name hadoopdatanode2 --hostname hadoopdatanode2 --link hadoopmaster:hadoopmaster gwess/centos7_hadoop_datanode

#docker exec -it hadoopslave bash -c 'echo "172.17.0.2      hadoopmaster " >> /etc/hosts'
#docker exec -it hadoop_slave bash -c "sed -i 's/hdfs\:\/\/localhost\:9000/hdfs\:\/\/hadoop_master\:9000/' /usr/local/hadoop/etc/hadoop/core-site.xml"
docker exec -it hadoopmaster bash -c 'echo "172.17.0.3      hadoopdatanode1 " >> /etc/hosts'
docker exec -it hadoopmaster bash -c 'echo "172.17.0.4      hadoopdatanode2 " >> /etc/hosts'

echo "Running hdfs..."
docker exec -it hadoopmaster bash -c '$HADOOP_PREFIX/bin/hdfs namenode -format mycluster && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/sbin/start-yarn.sh'
