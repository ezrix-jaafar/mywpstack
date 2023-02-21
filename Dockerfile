# Use the official WordPress image as the base
FROM wordpress:latest

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y \
        libmemcached-dev \
        libzip-dev \
        zlib1g-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmagickwand-dev \
        imagemagick \
        unzip

# Install necessary PHP extensions and configure php.ini
RUN docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install opcache pdo_mysql mysqli zip intl gd exif bcmath && \
    pecl install memcached redis imagick && \
    docker-php-ext-enable memcached redis imagick opcache

# Copy the nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf
