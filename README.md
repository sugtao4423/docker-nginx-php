# docker-nginx-php
[![](https://images.microbadger.com/badges/version/sugtao4423/nginx-php.svg)](https://microbadger.com/images/sugtao4423/nginx-php "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/sugtao4423/nginx-php.svg)](https://microbadger.com/images/sugtao4423/nginx-php "Get your own image badge on microbadger.com")

Based on Alpine Linux

## Environment variables
#### php-fpm.d/www.conf
name | conf name | default
--- | --- | ---
PHP_FPM_USER | listen.owner, user | nginx
PHP_FPM_GROUP | listen.group, group | nginx
PHP_FPM_LISTEN_MODE | listen.mode | 0660
PHP_FPM_PM_MAX_CHILDREN | pm.max_children | 25
PHP_FPM_PM_START_SERVERS | pm.start_servers | 10
PHP_FPM_PM_MIN_SPARE_SERVERS | pm.min_spare_servers | 5
PHP_FPM_PM_MAX_SPARE_SERVERS | pm.max_spare_servers | 20

#### php.ini
name | conf name | default
--- | --- | ---
PHP_MEMORY_LIMIT | memory_limit | 512M
PHP_MAX_UPLOAD | upload_max_filesize | 50M
PHP_MAX_FILE_UPLOAD | max_file_uploads | 200
PHP_MAX_POST | post_max_size | 100M
PHP_EXPOSE_PHP | expose_php | Off
PHP_TIMEZONE | date.timezone | Asia/Tokyo

## Volumes
* `/html`: nginx document root
* `/etc/nginx/conf.d/*.conf`: nginx confs in server directive (ex. location{})

## Port
* `80`: http
