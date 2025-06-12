# Usa a imagem oficial do PHP com Apache
FROM php:8.1-apache

# Instala extensões PHP necessárias para Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git \
    && docker-php-ext-install pdo_mysql zip

# Instala Composer (gerenciador de pacotes PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia o código da sua aplicação para dentro do container
COPY . /var/www/html

# Define permissões e configurações
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Habilita o mod_rewrite do Apache (necessário para o Laravel)
RUN a2enmod rewrite

# Expõe a porta 80 para acesso HTTP
EXPOSE 80
