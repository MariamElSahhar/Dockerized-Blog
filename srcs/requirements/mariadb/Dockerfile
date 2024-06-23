FROM alpine:3.18


RUN apk update
RUN apk add --no-cache mariadb

COPY db.conf /etc/mysql/
RUN mv /etc/mysql/db.conf

COPY ./db-setup.sh /var/lib/mysql/
WORKDIR /var/lib/mysql
RUN chmod +x db-setup.sh

EXPOSE 3306

CMD ["./db-setup.sh"]
