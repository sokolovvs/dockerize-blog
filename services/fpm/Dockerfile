FROM php:7.4-fpm

WORKDIR /var/www/blog

RUN apt-get update
RUN apt-get install -y \
        openssl \
        curl \
        wget \
        make \
        git \
        unzip \
        libpq-dev \
        libfreetype6-dev \
        libmcrypt-dev \
        libicu-dev \
                --no-install-recommends
RUN docker-php-ext-install pdo_pgsql

RUN pecl install xdebug-3.0.3
RUN docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | \
            php -- --install-dir=/usr/bin/ --filename=composer

ARG HOST_UID
ARG HOST_GID
ENV HOST_UID $HOST_UID
ENV HOST_GID $HOST_GID

RUN usermod -u $HOST_UID www-data && groupmod -g $HOST_GID www-data
