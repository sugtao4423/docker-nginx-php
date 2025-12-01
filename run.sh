#!/usr/bin/env bash

php-fpm${PHP_VER} -D
echo "php-fpm${PHP_VER} started"

nginx -g 'daemon on;'
echo 'nginx started'

trap_term(){
    echo 'exit'
    exit 0
}
trap 'trap_term' TERM

while :
do
    sleep 1
done
