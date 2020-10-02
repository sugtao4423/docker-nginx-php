FROM alpine:latest

LABEL maintainer "sugtao4423"

RUN adduser -D -u 1000 nginx && \
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
# curl
    apk --no-cache add curl && \
# php-fpm
    apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community add \
        php7 php7-curl php7-dom php7-exif php7-fileinfo php7-fpm \
        php7-gd php7-iconv php7-imagick php7-json php7-mbstring \
        php7-mysqli php7-pdo php7-pdo_mysql php7-pdo_sqlite \
        php7-session php7-sqlite3 php7-zip && \
    mkdir /var/run/php-fpm/ && adduser -D phpfpm && \
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
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 80

CMD ["/run.sh"]

