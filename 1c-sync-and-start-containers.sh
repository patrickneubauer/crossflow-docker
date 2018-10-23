#!/bin/sh

source setup-docker-machine-env.sh

echo "Evaluating SSH agent and synching and starting up containers ..."

eval $(ssh-agent)
ssh-add ~/.docker/machine/machines/crossflow/id_rsa
rsync -avzhe ssh --relative --omit-dir-times --progress ./ docker@$(docker-machine ip crossflow):$(pwd)
docker-compose up

echo "... terminated docker-compose up."
