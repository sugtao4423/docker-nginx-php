FROM alpine:latest

LABEL maintainer="sugtao4423"

ENV PHP_VER="84"

RUN addgroup -g 1000 -S nginx && \
    adduser -S -D -H -u 1000 -s /sbin/nologin -G nginx -g nginx nginx && \
    apk update && \
# bash
    apk --no-cache add bash && \
    sed -e "s/export\s*PS1=.*/export PS1='\\\\u@\\\\h:\\\\w # '/" -i /etc/profile && \
    ln -s /etc/profile /root/.bashrc && \
# JST TimeZone
    apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
# openrc
    apk --no-cache add openrc && \
    mkdir /run/openrc && \
    touch /run/openrc/softlevel && \
# nginx
    mkdir /run/nginx && \
    apk --no-cache add nginx && \
    rm -rf /etc/nginx/conf.d/* && \
    ln -s /dev/stdout /var/log/nginx/access.log && \
    ln -s /dev/stderr /var/log/nginx/error.log && \
# curl
    apk --no-cache add curl && \
# php-fpm
    apk --no-cache add \
        php${PHP_VER} \
        php${PHP_VER}-curl \
        php${PHP_VER}-dom \
        php${PHP_VER}-exif \
        php${PHP_VER}-fileinfo \
        php${PHP_VER}-fpm \
        php${PHP_VER}-gd \
        php${PHP_VER}-iconv \
        php${PHP_VER}-pecl-imagick \
        php${PHP_VER}-mbstring \
        php${PHP_VER}-mysqli \
        php${PHP_VER}-pdo \
        php${PHP_VER}-pdo_mysql \
        php${PHP_VER}-pdo_sqlite \
        php${PHP_VER}-session \
        php${PHP_VER}-sqlite3 \
        php${PHP_VER}-zip && \
    mkdir /var/run/php-fpm/ && \
    ln -s /dev/stderr /var/log/php${PHP_VER}/error.log && \
# clear apk cache
    rm -rf /var/cache/apk/*

ENV PHP_FPM_USER="nginx" \
    PHP_FPM_GROUP="nginx" \
    PHP_FPM_LISTEN_MODE="0660" \
    PHP_FPM_PM_MAX_CHILDREN="25" \
    PHP_FPM_PM_START_SERVERS="10" \
    PHP_FPM_PM_MIN_SPARE_SERVERS="5" \
    PHP_FPM_PM_MAX_SPARE_SERVERS="20" \
    PHP_MEMORY_LIMIT="512M" \
    PHP_MAX_UPLOAD="50M" \
    PHP_MAX_FILE_UPLOAD="200" \
    PHP_MAX_POST="100M" \
    PHP_EXPOSE_PHP="Off" \
    PHP_TIMEZONE="Asia/Tokyo"

COPY nginx.conf /etc/nginx/nginx.conf
COPY --chmod=755 run.sh /usr/local/bin/run.sh

VOLUME ["/html"]
EXPOSE 80

WORKDIR /html

CMD ["run.sh"]
