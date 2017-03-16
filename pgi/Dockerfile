FROM httpd:2.4
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
WORKDIR /usr/local/apache2/bin
CMD ["./apachectl", "-DFOREGROUND"]
