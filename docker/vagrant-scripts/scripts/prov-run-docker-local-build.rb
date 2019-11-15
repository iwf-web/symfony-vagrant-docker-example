# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_run_docker_local_build(config)
    $script = <<-SCRIPT
        cd /vagrant/docker/build-local
        ./docker_build.sh
SCRIPT

    config.vm.provision "run-docker-local-build", type: "shell", privileged: false, inline: $script

end
