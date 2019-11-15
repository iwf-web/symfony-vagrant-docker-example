# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_fix_app_data_permissions(config)
    $script = <<-SCRIPT
        sudo chown -R vagrant /home/vagrant/appdata
SCRIPT

    config.vm.provision "fix-app-data-permissions", type: "shell", privileged: false, run: "always", inline: $script

end
