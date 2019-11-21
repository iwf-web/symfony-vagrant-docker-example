Symfony 4 application with Docker in Vagrant
============================================


A Symfony 4 application running with Docker in an automatically provisioned Vagrant box.


Includes:

* Symfony 4 demo app
* Vagrant provisioning with vagrant-scripts

* PHP 7.1
* Nginx 1.14
* MySQL
* PhpMyAdmin


# Setup

Ensure to have to vagrant-vbguest plugin installed:
```
vagrant plugin install vagrant-vbguest
```

```
./bin/init_project.sh
cd docker/vagrant
vagrant up
```


