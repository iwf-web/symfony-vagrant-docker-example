#!/bin/bash

_IMAGE_TAG=example-company/vagrant-docker-example
_ROOT_PATH=../../
_CODEFILE="code.tar"
_DOCKER_BUILD_EXCLUDES="--exclude '${_CODEFILE}' --exclude ./.git --exclude .gitignore --exclude ./docker"

# create tarball of your code
echo "creating a tarball of this app..."
tar -cvpf ${_CODEFILE} ${_DOCKER_BUILD_EXCLUDES} ${_ROOT_PATH} >/dev/null

# build the base image
echo "building the base image..."
./base_image.sh

# build the application image
echo "building the application image..."
DOCKER_BUILDKIT=1 docker build --no-cache --force-rm --build-arg TARGET=application -t ${_IMAGE_TAG}:latest .

# build the webserver image
echo "building the webserver image..."
DOCKER_BUILDKIT=1 docker build --no-cache --force-rm --build-arg TARGET=webserver -t ${_IMAGE_TAG}:web-latest .

# remove tarfile
rm -f ${_CODEFILE}

echo "build finished. You can push your image to the registry with: "
echo "  docker push ${_IMAGE_TAG}:latest"
echo "  docker push ${_IMAGE_TAG}:web-latest"
