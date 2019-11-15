#!/usr/bin/env bash

# This file contains instructions to start the dev environment after each boot
# of the VM

echo "Starting docker containers. Please wait..."

mkdir -p ~/appdata/app/var/cache ~/appdata/app/var/logs ~/appdata/app/var/sessions

cd /vagrant/docker/run
docker-compose up -d

echo "Done. Have fun!"
