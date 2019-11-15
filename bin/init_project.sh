#!/bin/bash
#set -x

# force bash
if [ -z "$BASH_VERSION" ]; then
    exec bash "$0" "$@"
fi

# initials
BASE_PATH="$(dirname "$0")/.."

function copy_file() {
  if [ -r "$1" ]; then
    echo -n "Copying $1 -> $2 ..."
    cp $1 $2
    echo ' done.'
  fi
}

echo

echo -n '1. '; copy_file "$BASE_PATH/docker/vagrant/vagrant_settings.yml.dist" "$BASE_PATH/docker/vagrant/vagrant_settings.yml"
echo -n '2. '; copy_file "$BASE_PATH/docker/run/docker-compose.yml.dist" "$BASE_PATH/docker/run/docker-compose.yml"

echo
echo "Tip: Maybe you want to customize any of the copied files?"
echo
exit
