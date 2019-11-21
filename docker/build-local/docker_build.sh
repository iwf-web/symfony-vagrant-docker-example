#!/bin/bash
#set -x

_IMAGE_TAG=local/app

cd ../build
sh base_image.sh

cd ../build-local
# build the application image
echo "building the local application image..."
DOCKER_BUILDKIT=1 docker build --no-cache --force-rm --build-arg TARGET=application -t ${_IMAGE_TAG}:latest .

# build the webserver image
echo "building the local webserver image..."
DOCKER_BUILDKIT=1 docker build --no-cache --force-rm --build-arg TARGET=webserver -t ${_IMAGE_TAG}:web-latest .
