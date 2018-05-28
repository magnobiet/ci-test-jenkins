FROM jenkins/jenkins:alpine

LABEL maintainer="Magno Biét <magno.biet@gmail.com>"

ENV http_port=8080
ENV agent_port=50000

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

# Configure timezone
ENV timezone=America/Sao_Paulo
RUN apk --update add tzdata
RUN cp /usr/share/zoneinfo/$timezone /etc/localtime && echo $timezone > /etc/timezone

# Update and Install dependencies
RUN apk update
RUN apk --update add ca-certificates wget curl git zip

# Node.js
RUN apk --update add nodejs
RUN npm install -g npm yarn bower
# RUN npm install -g grunt-cli gulp-cli webpack

# Install PHP
RUN apk --update add php7 php7-phar php7-json php7-sqlite3 php7-mysqli php7-mysqli \
	php7-pgsql php7-pdo php7-mbstring php7-curl php7-gd php7-gettext php7-fpm \
	php7-dev php7-doc php7-imagick php7-zip

## Composer
RUN wget -c -O composer https://getcomposer.org/composer.phar
RUN chmod +x composer
RUN mv composer /usr/local/bin/composer

## PHPUnit
RUN wget -c -O phpunit https://phar.phpunit.de/phpunit-7.phar
RUN chmod +x phpunit
RUN mv phpunit /usr/local/bin/phpunit

## PHP CodeSniffer
RUN wget -c -O phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
RUN chmod +x phpcs
RUN mv phpcs /usr/local/bin/phpcs

RUN wget -c -O phpcbf https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
RUN chmod +x phpcbf
RUN mv phpcbf /usr/local/bin/phpcbf

## PHPLOC
RUN wget -c -O phploc https://phar.phpunit.de/phploc.phar
RUN chmod +x phploc
RUN mv phploc /usr/local/bin/phploc

## PHP Depend
RUN wget -c -O pdepend http://static.pdepend.org/php/latest/pdepend.phar
RUN chmod +x pdepend
RUN mv pdepend /usr/local/bin/pdepend

## PHP Mess Detector
RUN wget -c -O phpmd http://static.phpmd.org/php/latest/phpmd.phar
RUN chmod +x phpmd
RUN mv phpmd /usr/local/bin/phpmd

## PHP Copy/Paste Detector
RUN wget -c -O phpcpd https://phar.phpunit.de/phpcpd.phar
RUN chmod +x phpcpd
RUN mv phpcpd /usr/local/bin/phpcpd

## PHP Documentation Generator
RUN wget -c -O phpdox http://phpdox.de/releases/phpdox.phar
RUN chmod +x phpdox
RUN mv phpdox /usr/local/bin/phpdox

EXPOSE ${http_port}
EXPOSE ${agent_port}

USER jenkins
