#!/usr/bin/env bash

php-fpm${PHP_VER} -F &
PHP_FPM_PID=$!
echo "php-fpm${PHP_VER} started (PID: ${PHP_FPM_PID})"

nginx -g 'daemon off;' &
NGINX_PID=$!
echo "nginx started (PID: ${NGINX_PID})"

graceful_shutdown() {
  echo 'Received shutdown signal, starting graceful shutdown...'
  kill -QUIT ${NGINX_PID}
  kill -QUIT ${PHP_FPM_PID}
}

trap graceful_shutdown SIGINT SIGQUIT SIGTERM

wait ${PHP_FPM_PID} ${NGINX_PID}
