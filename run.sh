#!/bin/bash

sed -e "s|;listen.owner\s*=.\+|listen.owner = ${PHP_FPM_USER}|g" \
    -e "s|;listen.group\s*=.\+|listen.group = ${PHP_FPM_GROUP}|g" \
    -e "s|;listen.mode\s*=.\+|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" \
    -e "s|user\s*=.\+|user = ${PHP_FPM_USER}|g" \
    -e "s|group\s*=.\+|group = ${PHP_FPM_GROUP}|g" \
    -e "s|listen\s*=.\+|listen = /var/run/php-fpm/php-fpm.sock|i" \
    -e "s|pm.max_children\s*=.\+|pm.max_children = ${PHP_FPM_PM_MAX_CHILDREN}|i" \
    -e "s|pm.start_servers\s*=.\+|pm.start_servers = ${PHP_FPM_PM_START_SERVERS}|i" \
    -e "s|pm.min_spare_servers\s*=.\+|pm.min_spare_servers = ${PHP_FPM_PM_MIN_SPARE_SERVERS}|i" \
    -e "s|pm.max_spare_servers\s*=.\+|pm.max_spare_servers = ${PHP_FPM_PM_MAX_SPARE_SERVERS}|i" \
    -i /etc/php84/php-fpm.d/www.conf && \
sed -e "s|;*memory_limit\s*=.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" \
    -e "s|;*upload_max_filesize\s*=.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" \
    -e "s|;*max_file_uploads\s*=.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" \
    -e "s|;*post_max_size\s*=.*|post_max_size = ${PHP_MAX_POST}|i" \
    -e "s|expose_php\s*=.*|expose_php = ${PHP_EXPOSE_PHP}|i" \
    -e "s|;date.timezone\s*=.*|date.timezone = \"${PHP_TIMEZONE}\"|i" \
    -i /etc/php84/php.ini

php-fpm84 -D
echo 'php-fpm84 started'

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
