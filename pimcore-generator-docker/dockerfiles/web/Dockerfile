FROM leocantthinkofaname/lemon-pimcore:latest
RUN apk update && apk upgrade
# {BASH}RUN apk add bash
# {VIM}RUN apk add vim
RUN apk add composer php7.0-gd php7.0-mysqli php7.0-pdo_mysql
RUN cd /var/www/html && composer install