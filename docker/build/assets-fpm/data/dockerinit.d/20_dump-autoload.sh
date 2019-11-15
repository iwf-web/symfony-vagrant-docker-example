if [ "${RUNTIME_ENVIRONMENT}" != "local" ]; then
    cd /app
    composer dump-autoload --optimize --no-dev --classmap-authoritative
fi
