FROM richarvey/nginx-php-fpm
COPY app /var/www/app
RUN rm -rf /var/www/html && ln -s /var/www/app/web /var/www/html && mv /var/www/app/web/app.php /var/www/app/web/index.php
RUN SYMFONY_ENV=prod APP_ENV=prod APP_DEBUG=0 php /var/www/app/bin/console cache:clear --env=prod
