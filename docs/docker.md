# Mastering the Docker inside your vagrant box

[Back to main docs](https://github.com/iwf-web/symfony-vagrant-docker-example)


## Overview

The Docker daemon is running inside your Vagrant box. Docker Compose is also available.

Nothing from your application is actually running as a service in the Vagrant box directly, but only Docker containers.

The Vagrant box is a very flexible environment for Docker development.

You don't need to have Docker installed on your host machine.


## How Docker works

No, we won't provide you with a description of Docker here. // todo: Link some cool Docker descriptions.

But you should know the following:

- a **container** is an *instance* of an **image**
- an **Image** is a binary stored locally and/or on [Dockerhub](https://hub.docker.com). Images are templates for *containers*.
- a **Dockerfile** is a *recipe* that can be used to create an **image**
- a **Docker compose file** is a *technical description* of a *docker stack*, used the orchestrate many services inside a virtual network
   

And the following:

- every *image* can be based on any other *image* as a base image, adding files to it, changing stuff, and so on
- Several *containers* of the same *image* can run at once, each with a different configuration
- *containers* are usally configured by using *environment variables* or by mounting some local data into them
- If you stop and remove a running *container* all the data you changed inside it is lost forever!
- For storing persistent data inside a *container* you have to mount a docker *volume* or a *directory* inside it
- by default no *network ports* of the services in your *containers* are exposed to the host system. You have to configure that explicitly. And you can map ports from the "outside" to the "inside". You can start two webservers with the same image, both using port 80 inside, and access the first with port 8081 and the second with port 8082. 


## What's this Docker stack?

The Docker stack in this example project consists of 4 services (containers):

- `web`: The webserver, based on Nginx (your local image local/app:web-latest)
- `fpm`: The PHP FPM server, based on PHP FPM (your local image local/app:latest)
- `db`: The database server, based on MySQL (the IWF image)
- `phpmyadmin`: PhpMyAdmin, to manage your local DB (the official image)

   
## What are all these files for?

The most important files to customize are:

File                 | Description
---------------------|--------------
docker/build/Dockerfile.base   | This is the base image used as a base for the `local` and `production` images. Include everything here you need both locally and on the server, e.g. additional software or PHP modules.
docker/build/assets-fpm/*  | All the stuff in here is copied into the FPM image. See the section "Using the dockerinit.d scripts" inside this doc.
docker/build/Dockerfile  | This is a description on how your production image should be build, all the steps involved you might be currently doing on the server (e.g. composer install, yarn install, ...)
docker/build-local/Dockerfile  | this file is the recipe for your local development image. It's based on the base image defined in Dockerfile.base. Add all the stuff here you need for local (and ONLY for local) development.
docker/run/data/*   | Local data you want to mount into your containers, e.g. to override some configs or scripts in your images
docker/run/docker-compose.yml  | This is the description of your local docker stack, describing all the services you need
docker/run/docker-compose.yml.dist | This is checked in into your repo. Devs should use this file as a template for their own docker-compose.yml file.


The following scripts help you to build all the stuff:

File                 | Description
---------------------|--------------
docker/build/base_image.sh | Use this script to rebuild your base image
docker/build/build.sh  | Use this script to create your production images (fpm image and webserver image)
docker/build-local/docker_build.sh | Use this script to rebuild your local development image. It's automatically called once on provisioning the Vagrant box through the Vagrant scripts.



## Working with Docker

Access your Vagrant layer (`cd docker/vagrant`, `vagrant ssh`) to work with Docker:

### Starting, stopping and watching your stack

- Start: `docker-compose up -d`
- Stop: `docker-compose down`
- Watch logfiles: `docker-compose logs` or `docker-compose logs -f` (auto-update)

### Enter your containers

- Access a shell inside the FPM container: `docker exec -ti fpm bash`
- Access a shell inside the WEB container: `docker exec -ti sh`
- Access a shell inside the DB container: `docker exec -ti db bash`

### See what's running (or not)

`docker ps`

### See your images

`docker image ls`

Should look something like this:

```
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
local/app               latest              ce0d376a0490        2 hours ago         1.4GB
local/app-base          latest              ee39373edd71        2 hours ago         784MB
local/app               web-latest          fb2118223758        4 days ago          16.2MB
iwfwebsolutions/mysql   5.7-latest          05a375b76fc7        5 days ago          437MB
phpmyadmin/phpmyadmin   latest              91490af22618        4 weeks ago         454MB
```


## What's up with these dockerinit.d scripts?

Inside the folder `docker/build/assets-fpm/data/dockerinit.d/` you will find many scripts that will be run each time your production FPM container boots.

Here we defined some things you usually do for a Symfony project:

- `00_wait-for-deps.sh`: This one just waits until the database container is ready
- `01_dev_cache-clear.sh`: Clear Symfony's dev cache
- `02_prod_cache-clear.sh`: Clear Symfony's prod cache
- `03_export_variables.sh`: Export environment variables needed for cronjobs
- `10_doctrine-migrate.sh`: Runs `doctrine:migrations:migrate`
- `20_dump-autoload.sh`: Use composer to dump autoload to speedup your app on production servers

Have a look inside the documentation for our [PHP base image](https://github.com/iwf-web/docker-phpfpm) to find out how to use the 
provided scripts to include your own startup scripts.

