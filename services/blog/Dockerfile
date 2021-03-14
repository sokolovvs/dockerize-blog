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
RUN docker-php-ext-install sockets

RUN pecl install xdebug-3.0.3
RUN docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | \
            php -- --install-dir=/usr/bin/ --filename=composer

ENV NODE_VERSION=14.6.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

ARG HOST_UID
ARG HOST_GID
ENV HOST_UID $HOST_UID
ENV HOST_GID $HOST_GID

RUN usermod -u $HOST_UID www-data && groupmod -g $HOST_GID www-data
