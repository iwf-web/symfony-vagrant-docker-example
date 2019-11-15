# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_enable_ssh_password_auth(config)

    $script = <<-SCRIPT
        sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
        sed -i 's/PasswordAuthentication no//' /etc/ssh/sshd_config
        /etc/init.d/ssh restart
SCRIPT
    config.vm.provision "enable-ssh-password-auth", type: "shell", privileged: true, inline: $script
end
