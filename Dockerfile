ARG PHP_VERSION
FROM php:${PHP_VERSION}-cli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update
RUN apt-get install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev libicu-dev libzip-dev libonig-dev libxml2-dev libxslt1-dev \
    && docker-php-ext-install -j$(nproc) gd intl zip bcmath pdo_mysql sockets mbstring soap xsl