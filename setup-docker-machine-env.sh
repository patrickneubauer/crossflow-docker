#!/bin/sh

echo "Retrieving docker-machine environment commands ..."
docker-machine env crossflow
echo "... finished retrieving docker-machine environment commands."

echo "Enabling docker client to access created machine ..."
eval $(docker-machine env crossflow)
echo "... finished enabling docker client to access created machine."
