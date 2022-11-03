FROM php:7.3.3-apache
#bismillah
RUN apt-get update && apt-get upgrade -y --allow-unauthenticated
RUN docker-php-ext-install mysqli
EXPOSE 80
