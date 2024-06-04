FROM alpine:3.19

RUN apk update && apk add php-fpm curl

WORKDIR /var/www/html

RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz
RUN tar -xzvf wordpress.tar.gz --strip-components=1
RUN rm -rf wordpress.tar.gz

EXPOSE 9000

CMD ["php-fpm7", "-F"]
