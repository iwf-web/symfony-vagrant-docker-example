# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_chdir_to_docker_run(config)
    $script = <<-SCRIPT
        echo "cd /vagrant/docker/run" >> /home/vagrant/.bashrc
SCRIPT

    config.vm.provision "chdir-to-docker-run", type: "shell", privileged: false, inline: $script

end
