# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_copy_ssh_key(config)
    # copy the public SSH key of the host system user to the vagrant box to allow GIT access
    config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa", run: "always"
    config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub", run: "always"
end
