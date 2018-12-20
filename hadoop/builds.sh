#!/bin/bash

echo "========================================== building gwess/centos7"
docker build --rm -f Dockerfile_centos7 -t gwess/centos7 .

echo "========================================== building gwess/centos7_hadoop"
docker build --rm -f Dockerfile_hadoop --tag gwess/centos7_hadoop .

echo "========================================== gwess/centos7_hadoop_namenode"
docker build --rm -f Dockerfile_namenode --tag gwess/centos7_hadoop_namenode .
