#!/bin/sh

source setup-docker-machine-env.sh

echo "Building Crossflow Apache Hadoop components ..."
for i in hadoop namenode datanode resourcemanager nodemanager historyserver; do
    echo Building $i
    ( cd $i && ./build.sh)
done
echo "... finished building Crossflow Apache Hadoop components."

echo "Building Crossflow Apache Flink components ..."
update-java-alternative —jre-headless -s java-1.8.0-openjdk-amd64
set -e

TAG=1.5.3-hadoop2.8

build() {
    NAME=$1
    IMAGE=bde2020/flink-$NAME:$TAG
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build -t $IMAGE .
    cd -
}

build base
build master
build worker
#build submit
#build maven-template template/maven
#build sbt-template template/sbt
echo "... finished building Crossflow Apache Flink components."
