# Customize & handle your Vagrant box

[Back to main docs](https://github.com/iwf-web/symfony-vagrant-docker-example)


## Overview

The Vagrant box is *your* Docker environment. This is the place where you can issue all `docker` and `docker-compose` commands.

This is the place where you start, stop, kill, create and debug your Docker containers.
This is the place where you build the production images.
[Learn more about the Docker integration](docs/docker.md).

Always access your Vagrant box with: `cd docker/vagrant; vagrant ssh`

It's a slim box based on Debian Stretch. 


## Good to know: local data

Some application files will not be synchronised to your host system (your Mac/Win machine) to increase performance.

The following data will live in the folder `/home/vagrant/appdata`:

- Symfony cache
- Symfony logs
- MySQL database

The folders are defined in the file `docker/run/docker-compose.yml`.

Learn more about this file in the [Docker docs](docker.md).


## Settings

To change the name of the box, it's IP address or something else, you should edit the file `docker/vagrant/vagrant_settings.yml`:

This file is a local copy of `vagrant_settings.yml.dist` and should not be checked in to version control. 

Every developer can tweak the settings inside this file for his own system.

```ruby
# Change the hostname for your own project
hostname: "symfony-vagrant-docker-example"

# Change the IP to make sure that every project on your machine gets his own IP. You can choose anything in the range "192.168.x.x"
ip: "192.168.122.33"

# Change this to simplify finding your project in the VirtualBox UI
vm_name: "vagrant-docker-example"

# Use "nfs" when running on a Mac
# Use "rsync" for Windows
shared_folder_type: "nfs"

# This is only needed if you run this on a Windows machine and you used "rsync" as shared folder type
# Here you define the files you want to exclude from the sync process
rsync_exclude:
  - ".git/"
  - ".idea/"
  - "var/cache/*"
  - "var/logs/*"
  - "var/sessions/*"
  - "app/config/parameters.yml"
  - "run/data/log/nginx/*"
  - "run/data/log/supervisor/*"

# The resources you want this VM box to acquire
# Attention: Make sure you have enough RAM when running several Vagrant boxes at once
vm_memory: 1024
vm_cpus: 2
```


## Customizing startup & provisioning

If you want something inside your Vagrant box to automatically start on each boot or if you want to have something provisioned at provisioning time, use these entrypoints:

- `vagrant-setup.sh`: This is run as user "vagrant" and helps you to install additional stuff in the Vagrant box. This is run on the first `vagrant up` or on `vagrant provision`.
- `vagrant-run-after-boot.sh`: This is run each time you boot up the machine with `vagrant up` or `vagrant reload`. 


## Handling Vagrant

All of these commands should be issued inside `docker/vagrant` directory.

### Getting access

Use `vagrant ssh` to access your Vagrant box.

Inside the Vagrant box you're the master of all the [Docker stuff](docker.md).


### Starting, stopping, restarting

- Startup: `vagrant up`
- Shutdown: `vagrant halt`
- Restart: `vagrant reload`


### Killing

This destroys your whole box and all data inside it, e.g. data in your project's database.

`vagrant destroy`


### Run some provisioning stuff

See the docs of the [Vagrant Scripts](https://github.com/iwf-web/vagrant-scripts).

 
