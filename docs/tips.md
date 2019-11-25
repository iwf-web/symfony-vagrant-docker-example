# Recipes, tips & how to's

[Back to main docs](https://github.com/iwf-web/symfony-vagrant-docker-example)


## General Tips

Always be aware of the current **layer** you're working in.


- Your **host machine**: Here your development IDE is running, and you're working with GIT here.
- The **vagrant box** (accessible with `vagrant ssh`): Use this layer to start/stop/debug your Docker containers. See the [Docker docs](docker.md).
- The **fpm container** (accessible with `docker exec -ti fpm bash` from Vagrant): Use this layer to work "inside" your application. You can issue Symfony console commands here, install software via Composer or Yarn, ...


## Docker related

### Add a docker service

Working layer: Your host machine.

1. Edit the file `docker/run/docker-compose.yml` to include your new service.


Working layer: Vagrant box.

1. Restart your stack: `docker-compose down`, `docker-compose up -d`
2. See what's going on: `docker-compose -f logs` for all services, or `docker logs -f YOURSERVICE` to see the output of your new service 


If anything goes well, don't forget to update the `docker-compose.yml.dist` file and your colleagues that they should update their local stacks.


## Workflow

### Destroy all local data

Working layer: Vagrant.

You local cache, logs and DB live inside the Vagrant box in the folder `/home/vagrant/appdata`.

You can kill anything there with: `rm -rf ~/appdata/*` 


### Load a SQL dump into your database

Working layer: Your host machine.

1. Put your SQL dump into the following directory: `docker/run/data/dockerinit.d/mysql/`


Working layer: Vagrant.

1. Shutdown your database: `docker stop db`
3. Kill all DB data: `rm -rf ~/appdata/var/lib/mysql/*`
3. Start your DB: `cd docker/run`, `docker-compose up -d`
4. See what's going on: `docker logs -f db`


### Use the MySQL client inside your DB container

Working layer: Vagrant.

- Acess your DB container's shell: `docker exec -ti db bash`

Working layer: DB shell.

- `mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE`

