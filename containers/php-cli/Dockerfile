FROM php:8.3-cli-alpine

ENV BUILD_DEPS wget curl git grep build-base make autoconf g++
ENV PERSISTENT_DEPS net-tools hiredis-dev gmp-dev libmcrypt-dev libxml2-dev imagemagick-dev libjpeg-turbo-dev libpng-dev freetype-dev cyrus-sasl-dev libgsasl-dev libzip-dev pcre-dev libtool icu-dev supervisor

RUN apk upgrade --no-cache --update \
    && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
    && apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS \
    && apk --update --no-cache add && rm  -rf /tmp/* /var/cache/apk/* \
    && docker-php-ext-install mysqli pdo pdo_mysql xml exif pcntl bcmath zip \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install intl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    # Uninstall the grouping of dependencies called `.build-deps`.
    && apk del .build-deps
