#!/bin/sh

source setup-docker-machine-env.sh

echo "Connecting to docker-machine via SSH ..."
docker-machine ssh crossflow
echo "... terminated SSH connection to docker-machine."
