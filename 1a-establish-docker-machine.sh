#!/bin/sh

# Virtual machine memory below:
MEMORY=4096

# Virtual machine disk space below:
DISK_SPACE=25000

if [ -n "$1" ]
  then
    MEMORY=$1
fi

if [ -n "$2" ]
  then
    DISK_SPACE=$2
fi

echo "Creating crossflow docker-machine with $MEMORY MB of memory and $DISK_SPACE MB of disk space ..."
docker-machine create --virtualbox-memory $MEMORY --virtualbox-disk-size $DISK_SPACE crossflow
echo "... finished creating crossflow docker-machine with $MEMORY MB of memory and $DISK_SPACE MB of disk space."

source setup-docker-machine-env.sh
