FROM felipefinhane/php-nginx AS base
RUN apk --no-cache add php7-pdo_mysql php7-zip php7-xmlwriter
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /var/www/html

FROM base AS dev
RUN apk --no-cache add php7-sqlite3 php7-pdo_sqlite php7-xdebug
RUN cd /usr/local/bin && wget https://raw.githubusercontent.com/composer/getcomposer.org/d3a6ed2ed96ff423fb1991f22e4bcabd3db662f8/web/installer -O - -q | php -- --quiet && chmod a+x /usr/local/bin/composer.phar
COPY jenkins-build/tests /usr/local/bin/
COPY jenkins-build/tests-with-coverage-text /usr/local/bin/
COPY jenkins-build/tests-with-coverage-html /usr/local/bin/
COPY jenkins-build/check-if-all-tested.sh /usr/local/bin/
RUN cd /usr/local/bin && chmod a+x tests tests-with-coverage-text tests-with-coverage-html check-if-all-tested.sh
RUN echo 'zend_extension=xdebug.so' > /etc/php7/conf.d/xdebug.ini
ENTRYPOINT ["/bin/sh", "-c", "composer.phar install --no-scripts; sh /teste.sh"]

FROM dev AS build
COPY srcApp/composer.json /var/www/html/
COPY srcApp/composer.lock /var/www/html/
RUN composer.phar install --no-scripts --no-autoloader
COPY srcApp/ /var/www/html/
RUN composer.phar dump-autoload --no-scripts
RUN (rm -rf var; mkdir var) && chmod 777 -R var 
#RUN tests-with-coverage-text && check-if-all-tested.sh build/coverage-test-text
#RUN rm build/coverage-test-text
RUN composer.phar install --no-dev --no-scripts
RUN (rm -rf var; mkdir var) && chmod 777 -R var 

FROM base AS prod
COPY --from=build /var/www/html/ /var/www/html
ARG GIT_COMMIT_HASH=unspecified
ARG GIT_COMMIT_DATETIME=unspecified
ARG GIT_COMMIT_TITLE=unspecified
ARG DOCKER_IMAGE=unspecified
ENV GIT_COMMIT_HASH=$GIT_COMMIT_HASH
ENV GIT_COMMIT_DATETIME=$GIT_COMMIT_DATETIME
ENV GIT_COMMIT_TITLE=$GIT_COMMIT_TITLE
ENV DOCKER_IMAGE=$DOCKER_IMAGE
