FROM php:7.3-fpm-alpine

ENV BUILD_DEPS wget curl git grep build-base libmcrypt-dev libxml2-dev imagemagick-dev libjpeg-turbo-dev libpng-dev freetype-dev pcre-dev libtool make autoconf g++ cyrus-sasl-dev libgsasl-dev libzip-dev
# ENV BUILD_DEPS alpine-sdk coreutils wget git autoconf re2c

ENV PERSISTENT_DEPS net-tools hiredis-dev gmp-dev

# Update the packages in the container to their latest security patches.
RUN apk upgrade --no-cache --update

# Install your build-time and runtime dependencies.
# Give these groups of dependencies names like `.build-deps`
# and `.persistent-deps` that we can refer to later.
RUN apk add --no-cache --virtual .build-deps $BUILD_DEPS
RUN apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS

RUN apk --update --no-cache add

# Install extensions
RUN docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer xml exif pcntl bcmath zip
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Uninstall the grouping of dependencies called `.build-deps`.
RUN apk del .build-deps

EXPOSE 9000
CMD ["php-fpm"]
