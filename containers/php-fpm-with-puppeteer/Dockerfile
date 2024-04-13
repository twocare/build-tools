FROM php:8.3-fpm-alpine

ENV BUILD_DEPS wget curl git grep build-base make autoconf g++
ENV PERSISTENT_DEPS net-tools hiredis-dev gmp-dev libmcrypt-dev libxml2-dev imagemagick-dev libjpeg-turbo-dev libpng-dev freetype-dev cyrus-sasl-dev libgsasl-dev libzip-dev pcre-dev libtool icu-dev

RUN apk upgrade --no-cache --update \
    && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
    && apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS \
    && apk --update --no-cache add

RUN docker-php-ext-install mysqli pdo pdo_mysql xml exif pcntl bcmath zip \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install intl \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

RUN apk add --no-cache chromium nss freetype freetype-dev \
    harfbuzz ca-certificates ttf-freefont nghttp2-dev nodejs npm && \
    npm install -g puppeteer@1.19.0

# Uninstall the grouping of dependencies called `.build-deps`.
RUN apk del .build-deps

EXPOSE 9000
CMD ["php-fpm"]
