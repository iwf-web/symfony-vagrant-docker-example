# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_local_boot_scripts(config)

    if File.exist?("vagrant-setup.sh")
        # this one setups the application for local development (runs once on initial setup)
        config.vm.provision "vagrant-setup", type: "shell", path: "vagrant-setup.sh", privileged: false
    end

    if File.exist?("vagrant-run-after-boot.sh")
        # this one is always run to start the docker containers (runs on each start)
        config.vm.provision "startup", type: "shell", path: "vagrant-run-after-boot.sh", run: "always", privileged: false
    end

end
