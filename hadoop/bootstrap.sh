#!/bin/bash

/usr/sbin/init

$HADOOP_PREFIX/bin/hdfs namenode -format && $HADOOP_PREFIX/sbin/start-dfs.sh

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
