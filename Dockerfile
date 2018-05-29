FROM jenkins/jenkins:alpine

LABEL maintainer="Magno Biét <magno.biet@gmail.com>"

ENV HTTP_PORT=8080
ENV AGENT_PORT=50000
ENV TIMEZONE=America/Sao_Paulo

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

# Configure timezone
RUN apk --update add tzdata
RUN cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Update and install dependencies
RUN apk update
RUN apk --update add ca-certificates wget curl git zip

# Install Node.js
RUN apk --update add nodejs
RUN npm install -g npm yarn bower
# RUN npm install -g grunt-cli gulp-cli webpack

# Install PHP
RUN apk --update add php7

## Install PHP extensions
RUN apk --update add php7-imagick php7-imagick-dev php7-common php7-xml \
	php7-xmlreader php7-xmlrpc php7-xmlwriter php7-xsl php7-zip php7-sockets \
	php7-sqlite3 php7-sysvmsg php7-sysvsem php7-sysvshm php7-tidy \
	php7-tokenizer php7-wddx php7-phar php7-posix php7-pspell php7-recode \
	php7-session php7-shmop php7-simplexml php7-snmp php7-soap php7-opcache \
	php7-openssl php7-pcntl php7-pdo php7-pdo_dblib php7-pdo_mysql \
	php7-pdo_odbc php7-pdo_pgsql php7-pdo_sqlite php7-pgsql php7-iconv \
	php7-imap php7-intl php7-json php7-ldap php7-mbstring php7-mysqli \
	php7-mysqlnd php7-odbc php7-dba php7-dom php7-enchant php7-exif \
	php7-fileinfo php7-ftp php7-gd php7-gettext php7-gmp php7-bcmath php7-bz2 \
	php7-calendar php7-cgi php7-ctype php7-curl php7-fpm php7-pear \
	php7-apache2 php7-dev php7-doc php7-embed php7-litespeed php7-phpdbg

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

# Expose default ports
EXPOSE ${HTTP_PORT}
EXPOSE ${AGENT_PORT}

USER jenkins
