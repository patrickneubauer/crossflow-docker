#!/bin/sh

source setup-docker-machine-env.sh

echo "Changing into workflow directory ..."
cd ../workflow/execution/execution-core

echo "Running tests via maven ..."
docker run -it --rm --network crossflow --name crossflow-cli -v "$PWD":/usr/src/crossflow -v "$HOME/.m2":/root/.m2 -v "$PWD/target:/usr/src/crossflow/target" -w /usr/src/crossflow maven:3.5.4-jdk-8 mvn -Dtest=GitRepoCloneToLocalFSTest -DfailIfNoTests=false test
echo "... finished running tests via maven."
