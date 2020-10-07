ARG PHP_VERSION
FROM php:${PHP_VERSION}-cli

SHELL ["/bin/bash", "-c"]
ARG PHP_VERSION
ARG PHP_EXTENSIONS="gd intl zip bcmath pdo_mysql sockets mbstring soap xsl mcrypt sodium"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev libicu-dev libzip-dev libonig-dev libxml2-dev libxslt1-dev libmcrypt-dev libsodium-dev\
    && PHP_VERSION=$(echo ${PHP_VERSION} | awk -F '.' '{print $1$2}') \
    && PHP_PACKAGES= && for PKG in ${PHP_EXTENSIONS}; do \
               if [[ ${PKG} = "mcrypt" ]] && (( ${PHP_VERSION} > 71 )); then continue; fi; \
               if [[ ${PKG} = "sodium" ]] && (( ${PHP_VERSION} < 72 )); then continue; fi; \
               PHP_PACKAGES+="${PKG} "; \
    done \
    && docker-php-ext-install -j$(nproc) ${PHP_PACKAGES}