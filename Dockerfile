FROM php:7.4-apache

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libonig-dev \
  libxml2-dev \
  libzip-dev \
  unzip \
  wget \
  cron \
  mariadb-client \
  libicu-dev \
  libldap2-dev \
  zlib1g-dev \
  libssl-dev \
  libsodium-dev \
  libbz2-dev \
  libcurl4-openssl-dev \
  && docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    intl \
    zip \
    bz2 \
    gd \
    curl \
    exif \
    opcache \
    ldap \
    sodium

# Baixar o GLPI
WORKDIR /var/www/html
RUN rm -rf ./*
RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.14/glpi-10.0.14.tgz && \
    tar -xvzf glpi-10.0.14.tgz && \
    mv glpi/* . && \
    rm -rf glpi glpi-10.0.14.tgz

# Corrigir permissões
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
