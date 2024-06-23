FROM alpine:3.19

RUN apk add --no-cache  php82 \
                        php82-phar \
                        php82-fpm \
                        php82-mysqli \
                        curl \
                        bash

COPY ./wp-setup.sh ./wp-setup.sh
RUN chmod +x ./wp-setup.sh

EXPOSE 9000

CMD [ "./wp-setup.sh" ]
