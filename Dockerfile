FROM php:5.6.33-fpm
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
libbz2-dev \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev \
libmcrypt-dev 

RUN apt-get install -y mariadb-client

RUN apt-get install -y libxslt-dev \
libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-install bz2 \
&& docker-php-ext-install calendar \
&& docker-php-ext-install exif \
&& docker-php-ext-install gettext \
&& docker-php-ext-install mcrypt \
&& docker-php-ext-install mysql \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install pcntl \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install shmop \
&& docker-php-ext-install sockets \
&& docker-php-ext-install sysvmsg \
&& docker-php-ext-install sysvsem \
&& docker-php-ext-install sysvshm \
&& docker-php-ext-install wddx \
&& docker-php-ext-install xsl \
&& docker-php-ext-install zip


RUN pecl install -o -f memcache-2.2.7.tgz \
&& echo extension=memcache.so >> /usr/local/etc/php/conf.d/memcache.ini 

RUN pecl install -o -f igbinary-2.0.8.tgz \
&& docker-php-ext-enable igbinary

RUN pecl install -o -f redis-4.3.0.tgz \
&&  rm -rf /tmp/pear \
&&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini
