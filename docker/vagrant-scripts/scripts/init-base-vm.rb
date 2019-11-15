# -*- mode: ruby -*-
# vi: set ft=ruby :

def init_base_vm(config)
    config.vm.box = "debian/contrib-stretch64"
    config.vm.box_check_update = false
    config.vbguest.auto_update = false # temporary until base box is updated (see https://github.com/dotless-de/vagrant-vbguest/issues/351)

    config.ssh.username = "vagrant"
end
