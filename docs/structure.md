# Understand the project structure


[Back to main docs](https://github.com/iwf-web/symfony-vagrant-docker-example)


## Understand the different layers

// todo


## Directory structure of this project

### Symfony/application directories

The following directories are mostly taken directly from a freshly installed Symfony 4 project.

Directory    | Description
-------------|--------------
bin          | Symfony's "bin" directory. Also contains the customized `init_project.sh` to easily setup the project
config       | Symfony's "config" directory.
data         | Data you might upload or generate in your application. Mounted to `/app/data` for your project.
public       | Symfony's "public" directory. The root for the webserver.
src          | Symfony's "src" directory.
tests        | Symfony's "test" directory.
var          | Symfony's "var" directory.
vendor       | Symfony/Composer's "vendor" directory.


### Directories for local dev & Docker builds

The following directories contain infrastructure related stuff. You can take the `docker` folder and move it into another project, customizing it for your needs.

Directory    | Description
-------------|--------------
docker       | Contains all the "special" stuff to build and run the local Vagrant box and to build Docker images for deployment
docker/build | The Dockerfiles and assets for building production images. See the [Docker docs](docker.md)!
docker/build-local | The Dockerfile and build script for setting up the Docker images for local development
run          | The Docker Compose Stackfile and assets you only need for for local development
vagrant      | Contains the Vagrant stuff and entrypoints for customizing your Vagrant box. See the [Vagrant docs](vagrant.md).
vagrant-scripts | **You should not touch the files in this directory**. They're directly copied from the repository https://github.com/iwf-web/vagrant-scripts.
docs         | The documentation you're reading.

