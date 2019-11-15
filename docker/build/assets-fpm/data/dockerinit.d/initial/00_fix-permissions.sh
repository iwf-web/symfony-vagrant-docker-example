#!/bin/bash
OWNER=www-data:www-data
TARGETDIR="/app /data"

if [ "${RUNTIME_ENVIRONMENT}" != "local" ]; then
  echo "Setting $OWNER as owner of '$TARGETDIR' ..."
  sudo chown -R $OWNER $TARGETDIR
fi