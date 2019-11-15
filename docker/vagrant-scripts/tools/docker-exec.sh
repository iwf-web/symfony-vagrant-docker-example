#!/bin/sh
vagrant ssh -c "docker exec -ti fpm env TERM=xterm-256color $@"
