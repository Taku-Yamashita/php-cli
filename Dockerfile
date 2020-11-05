ARG PHP_VERSION
FROM php:${PHP_VERSION}-cli
LABEL org.opencontainers.image.source=https://github.com/taku-yamashita/php-cli

SHELL ["/bin/bash", "-c"]
ARG PHP_VERSION
ARG COMPOSER_VERSION
ARG COMPOSER_VERSION_1="1.10.17"
ARG COMPOSER_VERSION_2="2.0.4"
ARG PHP_EXTENSIONS="gd intl zip bcmath pdo_mysql sockets mbstring soap xsl mcrypt sodium"

RUN apt-get update && apt-get install -y \
        unzip git \
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

RUN C_VERSION=${COMPOSER_VERSION_1} \
    && if [[ ${COMPOSER_VERSION} = "v2" ]]; then C_VERSION=${COMPOSER_VERSION_2}; fi; \
    curl -sS https://getcomposer.org/installer | php -- --version=${C_VERSION} --install-dir=/usr/local/bin --filename=composer \
    && composer config -g repos.packagist composer https://packagist.jp \
    && if [[ ${COMPOSER_VERSION} = "v1" ]]; then composer global require hirak/prestissimo; fi; \