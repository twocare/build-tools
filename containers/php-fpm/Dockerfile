FROM php:7.3.17-fpm-alpine

ENV BUILD_DEPS wget curl git grep build-base make autoconf g++
ENV PERSISTENT_DEPS net-tools hiredis-dev gmp-dev libmcrypt-dev libxml2-dev imagemagick-dev libjpeg-turbo-dev libpng-dev freetype-dev cyrus-sasl-dev libgsasl-dev libzip-dev pcre-dev libtool icu-dev

RUN apk upgrade --no-cache --update
RUN apk add --no-cache --virtual .build-deps $BUILD_DEPS
RUN apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS

RUN apk --update --no-cache add

RUN docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer xml exif pcntl bcmath zip
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Uninstall the grouping of dependencies called `.build-deps`.
RUN apk del .build-deps

EXPOSE 9000
CMD ["php-fpm"]
