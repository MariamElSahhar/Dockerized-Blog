FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils

COPY ./db.conf /etc/my.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

CMD ["mysqld"]
