# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_install_docker(config)
    $script = <<-SCRIPT
        sudo apt-get update
        sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common curl
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
        sudo add-apt-repository \
           "deb [arch=amd64] https://download.docker.com/linux/debian \
           $(lsb_release -cs) \
           stable"
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
        sudo groupadd docker
        sudo usermod -aG docker vagrant
        sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
SCRIPT
    config.vm.provision "install-docker", type: "shell", privileged: false, reset: true, inline: $script
end
