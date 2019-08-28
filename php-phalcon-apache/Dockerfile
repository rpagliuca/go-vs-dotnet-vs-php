FROM php:7.2-apache

ARG PSR_VERSION=0.6.1

ARG PHALCON_VERSION=3.4.3
ARG PHALCON_EXT_PATH=php7/64bits

RUN set -xe && \
        curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PSR_VERSION}.tar.gz && \
        cd ${PWD}/php-psr-${PSR_VERSION} && \
        phpize && \
        ./configure && \
        make && \
        make test && \
        make install 

RUN set -xe && \
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PHALCON_VERSION}.tar.gz && \
        cd ${PWD}/cphalcon-${PHALCON_VERSION}/build/ && \
        ./install

RUN apt-get update && \
        apt-get install -y zlib1g-dev && \ 
        apt-get install -y libpng-dev && \
        apt-get install nano

RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo_mysql

RUN a2enmod rewrite