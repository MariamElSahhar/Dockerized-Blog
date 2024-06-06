FROM alpine:3.19

RUN apk add --no-cache      php \
                            php-fpm \
                            php-mysqli \
                            php-json \
                            php-opcache \
                            php-xml \
                            php-phar \
                            php-curl \
                            php-mbstring \
                            php-gd \
                            php-dom \
                            php-session \
                            php-zlib \
                            php-fileinfo \
                            curl \
                            tar


RUN mkdir -p /run/php && \
    sed -i 's/;daemonize = yes/daemonize = no/' /etc/php82/php-fpm.conf && \
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php82/php.ini

RUN mkdir -p /var/www
RUN curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/wordpress-6.5.4.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/ && \
    rm /tmp/wordpress.tar.gz && \
    chown -R nobody:nogroup /var/www/wordpress

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm82", "-F"]
