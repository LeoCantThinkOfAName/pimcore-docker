FROM test:test
RUN apk update && apk upgrade
RUN apk add composer php7.0-gd php7.0-mysqli php7.0-pdo_mysql
RUN cd /var/www/html && composer install