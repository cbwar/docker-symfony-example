FROM php:8.0-cli

RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list

RUN apt-get update && \
    apt-get install -y wget git unzip supervisor symfony-cli && \
    pecl install redis-5.3.6 && docker-php-ext-enable redis && \
    pecl install xdebug && docker-php-ext-enable xdebug && \
    apt-get install -y libcurl4-openssl-dev libicu-dev && \
    docker-php-ext-configure intl && docker-php-ext-install intl && \
    docker-php-ext-install pdo_mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://deb.nodesource.com/setup_14.x -O - | bash \
    && apt-get install nodejs\
    && apt-get clean \
    && npm --version \
    && npm install --global yarn \
    && yarn --version

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv /composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

RUN addgroup --gid 1000 dev && \
    adduser --home /home/dev --uid 1000 --gid 1000 dev

COPY php.ini /etc/php/8.0/fpm/conf.d/30-custom.ini
COPY php.ini /etc/php/8.0/cli/conf.d/30-custom.ini

COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["/usr/bin/supervisord"]

VOLUME /home/dev
USER dev
WORKDIR /sources

EXPOSE 8000
