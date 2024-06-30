FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client

COPY ./my.cnf /etc/my.cnf
COPY ./tools/db-setup.sh ./db-setup.sh
RUN chmod +x ./db-setup.sh

EXPOSE 3306

CMD ["./db-setup.sh"]
