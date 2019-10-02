FROM debian:10

ENV TZ=Asia/Shanghai LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN sed -i -e 's@ .*.ubuntu.com@ http://mirrors.aliyun.com@g' -e 's@ .*.debian.org@ http://mirrors.aliyun.com@g' /etc/apt/sources.list; \
    apt-get update ; apt-get install -y php-dev php-fpm php-mysql php-redis php-pear php-pgsql php-amqp php-bcmath php-curl php-date \
      php-dom php-gd php-imagick php-intl php-json php-xml php-mbstring php-memcache php-memcached php-mongodb php-stomp \
      runit procps vim wget curl mariadb-client libmcrypt-dev \
      libjemalloc-dev libargon2-0-dev libnghttp2-dev \
      libmagickwand-dev imagemagick librabbitmq-dev libxml2-dev libc6-dev  libevent-dev \
      libsodium-dev libssl-dev libmcrypt-dev libcurl4-openssl-dev libmemcached-dev \
      re2c libpcre3-dev libwebp-dev  libpq-dev libpqxx-dev; \
    echo -n | pecl install -f mcrypt ; \
    mkdir -p /etc/service/php /run/php ; \
    bash -c 'echo -e "extension=mcrypt.so\n" > /etc/php/7.3/fpm/conf.d/99-mcrypt.ini' ;\
    bash -c 'echo -e "upload_max_filesize=80M\npost_max_size=80M\ndate.timezone=Asia/Shanghai" > /etc/php/7.3/fpm/conf.d/99-php.ini' ;\
    sed -i -e 's/^listen =.*/listen = 0.0.0.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf ;\
    bash -c 'echo -e "#!/bin/bash\nexec /usr/sbin/php-fpm7.3 --nodaemonize --fpm-config /etc/php/7.3/fpm/php-fpm.conf" > /etc/service/php/run' ; \
    chmod 755 /etc/service/php/run

EXPOSE 80/tcp 443/tcp 9000/tcp 7000/tcp

CMD ["runsvdir", "/etc/service"]
