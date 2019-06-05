#!/bin/sh

docker build --no-cache --squash -t registry.cloud.twocare.co/php-7.3-fpm .
docker push registry.cloud.twocare.co/php-7.3-fpm