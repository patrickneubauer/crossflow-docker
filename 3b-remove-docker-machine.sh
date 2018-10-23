#!/bin/sh

echo "Removing crossflow docker-machine (requires confirmation)..."
docker-machine rm crossflow
echo "... finished removing crossflow docker-machine."
