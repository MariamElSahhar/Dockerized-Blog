FROM alpine:3.18

RUN apk add --no-cache  php \
                        php-phar \
                        php-fpm \
                        php-mysqli \
                        curl \
                        bash

COPY ./wp-setup.sh ./wp-setup.sh
RUN chmod +x ./wp-setup.sh

EXPOSE 9000

CMD [ "./wp-setup.sh" ]
