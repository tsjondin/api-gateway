FROM php:7.0-fpm
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY fpm/api.conf /usr/local/etc/php-fpm.d/api.conf
COPY . /usr/src/app

EXPOSE 9000
CMD [ "./run-service.sh" ]
