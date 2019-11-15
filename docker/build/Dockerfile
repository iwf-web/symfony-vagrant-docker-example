ARG TARGET

# ================================================================================= APP
FROM local/app-base:latest AS application

# switch to root for creating directories and changing ownerships
USER root

COPY ./code.tar /tmp/

# copy code to /app directory
RUN mkdir -p /app && \
    tar -xf /tmp/code.tar -C /app/  && \
    chown -R www-data:www-data /app


# you should ensure that you always switch back to www-user
USER www-data

# install app and cleanup
WORKDIR /app
RUN composer install && \
    php bin/console --env=prod assets:install && \
    sudo apt-get clean && \
    sudo rm -rf /app/var/cache/* /tmp/* /var/tmp/* /usr/share/doc/* /var/lib/apt/lists/* /var/www/.composer



# =================================================================================== WEB
FROM iwfwebsolutions/nginx:1.14-latest AS webserver

ENV APP_FRAMEWORK=symfony4

# optional: copy additional assets
# COPY ./assets-web/ /

# copy all static site data from the base image into /app/web (the document root)
COPY --from=application /app/public /app/web


# =================================================================================== CHOOSE
FROM $TARGET
