Vagrant-Dev-Scripts
===================

This is the central managed scripting resource for local Vagrant development.


ATTENTION
---------

**PLASE DO NOT MAKE CHANGES TO THE vagrant-scripts FOLDER IN YOUR PROJECT.**

Use the provided customization points (see below) and centrally update the vagrant-scripts project in GIT.


Installation in your project
----------------------------

* From the root folder of your project, run:
  `git subtree add --prefix docker/vagrant-scripts git@git.iwf.io:helper/vagrant-scripts.git master --squash`
  If you get a error "'master' does not refer to a commit", checkout master branch first in your local project and then checkout dev branch again
* Create the folder `docker/vagrant` (if not already existing)
* Create a `Vagrantfile` in your `vagrant` folder containing this line: `load '../vagrant-scripts/Vagrantfile.dist'`
* Copy the `vagrant_settings.yml.dist` to a `vagrant_settings.yml.dist` in your `vagrant` folder and customize it for your users
* Go on as usual to setup your local vagrant/docker stuff (copy .dist to local copy, run vagrant up...)


Update
------

From time to time, and to use newly introduced features, you should upgrade your vagrant-scripts:

* `git subtree pull --prefix docker/vagrant-scripts git@git.iwf.io:helper/vagrant-scripts.git master --squash`
 

Customization
-------------

* Use the `vagrant_settings.yml(.dist)` to specify developer specific settings for local development
* Setup the following scripts in your `vagrant` folder:
  * `vagrant-setup.sh`: this one is run once on the first `vagrant up` and on `vagrant provision`
  * `vagrant-run-after-boot.sh`: this one is run each time you boot up the machine with `vagrant up` or `vagrant reload`
* In rare special cases you can customize the `Vagrantfile` in your `vagrant` folder to include a custom set of scripts


Usage
-----

The scripts register some provisioning scripts which can be run even after a project was setup. The usage is always the same:

`docker provision --provision-with="PROVISIONER"`

The following provisioners only run on initial setup, but can be re-run later:

* `startup`: Use this one to run the project-specific `vagrant-run-after-boot.sh` script (if available)
* `vagrant-setup`: Use this one to run the project-specific `vagrant-setup.sh` script (if available)
* `docker-login`: Use this one to re-login to Docker in your Vagrant box
* `run-docker-local-build`: Use this one to run the local Docker build in your Vagrant box
* `install-docker`: Use this one to update Docker inside your Vagrant box

To re-provision the whole machine, run: `vagrant provision`


Migrate your project to vagrant-scripts
---------------------------------------

To migrate your existing project to these centrally managed vagrant scripts, perform these steps:

* Remove the following files from your docker/vagrant folder: `Vagrantfile`, `tools`
* Remove the following sections from your `vagrant-setup.sh` file because they are now done through the central scripts. Normally the file
  will be empty (except comments) after removing this stuff:
  * install docker release
  * create PhpStorm PHP-Proxy-Script
  * run the local Docker build
* Perform the steps above: "Installation in your project"

