FROM php:7.4-fpm-alpine

# Install essential build tools
RUN apk add --no-cache \
    git \
    yarn \
    autoconf \
    g++ \
    make \
    openssl-dev \
    nano

# Optional, force UTC as server time
RUN echo "UTC" > /etc/timezone

RUN apk add --no-cache $PHPIZE_DEPS \
     && pecl install xdebug-2.9.5 \
     && docker-php-ext-enable xdebug

RUN docker-php-ext-install mysqli pdo pdo_mysql opcache \
    && docker-php-ext-enable opcache

WORKDIR /var/www/html
