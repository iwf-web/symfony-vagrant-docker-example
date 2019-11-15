# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_create_app_data_folders(config)
    $script = <<-SCRIPT
        mkdir -p /home/vagrant/appdata/var/lib/mysql
        sudo chown -R vagrant /home/vagrant/appdata
SCRIPT

    config.vm.provision "create-app-data-folders", type: "shell", privileged: false, inline: $script

end
