FROM alpine:3.18

RUN apk add --no-cache mariadb mariadb-client 

COPY db.conf /etc/my.cnf
COPY ./db-setup.sh ./db-setup.sh
RUN chmod +x ./db-setup.sh

EXPOSE 3306

CMD ["./db-setup.sh"]
