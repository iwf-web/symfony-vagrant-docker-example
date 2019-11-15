#!/bin/sh
vagrant ssh -c "docker exec -t fpm env TERM=xterm-256color /app/vendor/bin/phpunit"