FROM debian:10

RUN sed -i -e 's@ .*.ubuntu.com@ http://mirrors.aliyun.com@g' -e 's@ .*.debian.org@ http://mirrors.aliyun.com@g' /etc/apt/sources.list; \
    apt-get update ; apt-get install -y php-fpm php-mysql php-redis php-pgsql php-amqp php-bcmath php-curl php-date \
      php-dom php-gd php-imagick php-intl php-json php-xml php-mbstring php-memcache php-memcached php-mongodb php-stomp \
      runit mariadb-client \
      libjemalloc-dev libargon2-0-dev libnghttp2-dev \
      libmagickwand-dev imagemagick librabbitmq-dev libxml2-dev libc6-dev  libevent-dev \
      libsodium-dev libssl-dev libmcrypt-dev libcurl4-openssl-dev libmemcached-dev \
      re2c libpcre3-dev libwebp-dev  libpq-dev libpqxx-dev; \
    mkdir -p /etc/service/php ; \
    bash -c 'echo -e "#!/bin/bash\nexec /usr/sbin/php-fpm7.3 --nodaemonize --fpm-config /etc/php-fpm.conf" > /etc/service/php/run' ; \
    chmod 755 /etc/service/php/run

EXPOSE 80/tcp 443/tcp 9000/tcp 7000/tcp

CMD ["runsvdir", "/etc/service"]
