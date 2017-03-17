FROM php:7-fpm-alpine

COPY fpm/api.conf /usr/local/etc/php-fpm.d/api.conf

RUN mkdir -p /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app

EXPOSE 9000
RUN [ "chown", "-R", "www-data:www-data", "/usr/src/app" ]
CMD [ "/usr/local/sbin/php-fpm" ]
