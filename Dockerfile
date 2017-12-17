FROM php:7.1.12-cli

RUN apt-get update && apt-get install -y \
    git zip unzip libicu52 libicu-dev libpng12-dev\
    --no-install-recommends && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-install intl pdo_mysql gd exif
RUN mkdir /var/www && chown www-data:www-data /var/www && chmod 775 /var/www \
    && mkdir /workspace && chown www-data:www-data /workspace && chmod 775 /workspace
WORKDIR /workspace
RUN curl -s https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer
RUN echo "umask 0002" >> /etc/bash.bashrc
COPY entrypoint.sh /usr/local/bin

EXPOSE 8765
ENTRYPOINT ["entrypoint.sh"]
