# -*- mode: ruby -*-
# vi: set ft=ruby :

def vagrant_plugins_config(config)

    unless Vagrant.has_plugin?("vagrant-hostsupdater")
      system("vagrant plugin install vagrant-hostsupdater")
      puts "Dependency 'vagrant-hostsupdater' installed, please try the command again."
      exit
    end

    unless Vagrant.has_plugin?("vagrant-notify-forwarder")
      system("vagrant plugin install vagrant-notify-forwarder")
      puts "Dependency 'vagrant-notify-forwarder' installed, please try the command again."
      exit
    end

    # Configure the window for gatling to coalesce writes.
    if Vagrant.has_plugin?("vagrant-gatling-rsync")
      config.gatling.latency = 1.5
      config.gatling.time_format = "%H:%M:%S"

       # Automatically sync when machines with rsync folders come up.
       config.gatling.rsync_on_startup = false
    end
end
