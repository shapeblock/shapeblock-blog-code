FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev wget mysql-client git

RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
     && docker-php-ext-install gd \
     && :\
     && docker-php-ext-install pdo pdo_mysql opcache zip \
     && docker-php-ext-enable pdo pdo_mysql opcache zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /code

# Don't allow search engines to index non-prod envs.
RUN if [ -n "$NON_PROD" ] ; then printf "User-agent: *\nDisallow: /\nNoindex: /\n" > ./web/robots.txt; fi
