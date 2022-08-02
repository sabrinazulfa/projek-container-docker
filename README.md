# DEPLOY APLIKASI MENGGUNAKAN CONTAINER

Disini saya akan menjelaskan skema deploy aplikasi menggunakan docker.
Aplikasi yang digunakan adalah php 7.3, yang didukung oleh:
- Webserver [apache]
- Database server [MySQL] 

Semua komponen dipackage dengan docker

## Menjalankan Postgres dengan Docker

Step 1: Install docker dan docker-compose
'sudo apt install docker docker-compose'

selanjutnya jalankan perintah ini, agar bisa akses tanpa menggunakan sudo
'sudo groupadd docker && sudo usermod -aG docker $USER'

keluar dan jalankan di terminal
'newgrp docker'

Step 2: Setting up the PHP development environment
mkdir web_dev
cd web_dev

Then we will create docker-compose file with: 

nano docker-compose.yml

    version: '3.3'

    services:
      web:
           image: php:7.3-apache
            container_name: php73
            volumes:
               - ./php:/var/www/html/
            ports:
              - 8008:80

lalu, silahkan buat file /index.php
<?php
phpinfo();

step 3: MYSQL dan Apache support
silahkan buat Dockerfile, yang berapa di sebelah PHP directory:
FROM php:7.3.3-apache
RUN apt-get update && apt-get upgrade -y
RUN docker-php-ext-install mysqli
EXPOSE 80

Build Mysql service, seperti berikut:
db:
  container_name: mysql8
  image: mysql:latest
  command: --default-authentication-plugin=mysql_native_password
  restart: always
  environment:
    MYSQL_ROOT_PASSWORD: root
    MYSQL_DATABASE: test_db
    MYSQL_USER: devuser
    MYSQL_PASSWORD: devpass
   ports:
       - 6033:3306

taruh command diatas tepat dibawah perintah web di Dockerfile

Step 5: Buka browser untuk mulai mengakses app PHP
```bash
http://IPHOST:8081
```
Dan akan muncul PHP.info sebagai outputnya