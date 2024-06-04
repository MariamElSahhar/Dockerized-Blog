FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
    nginx \
    php7 \
    php7-fpm \
    php7-mysqli \
    php7-curl \
    php7-gd \
    php7-intl \
    php7-mbstring \
    php7-soap \
    php7-xml \
    php7-xmlrpc \
    php7-zip \
    wget

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN rm latest.tar.gz

EXPOSE 9000

CMD ["nginx", "-g", "daemon off;"]
