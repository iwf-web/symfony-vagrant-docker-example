#!/bin/bash
#set -x

cd ../build
sh base_image.sh

cd ../build-local
docker build -f Dockerfile.web -t local/app-web:latest  .
docker build -f Dockerfile.app -t local/app:latest  .
