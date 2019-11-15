# -*- mode: ruby -*-
# vi: set ft=ruby :

def prov_install_php_proxy(config)

    $script = <<-SCRIPT
        echo 'if [ ! -z "$XDEBUG_CONFIG" ]; then docker exec -e XDEBUG_CONFIG=$XDEBUG_CONFIG -e IDE_PHPUNIT_CUSTOM_LOADER=/app/vendor/autoload.php -t fpm php "$@"; else docker exec -e IDE_PHPUNIT_CUSTOM_LOADER=/app/vendor/autoload.php -t fpm php "$@"; fi;' >/home/vagrant/php && chmod +x /home/vagrant/php
SCRIPT

    config.vm.provision "install-php-proxy", type: "shell", privileged: false, inline: $script
end
