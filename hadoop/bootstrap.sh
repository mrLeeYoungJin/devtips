#!/bin/bash

$HADOOP_PREFIX/bin/hdfs namenode -format && $HADOOP_PREFIX/sbin/start-dfs.sh
