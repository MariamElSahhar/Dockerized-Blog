FROM alpine:3.19

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -newkey rsa:2048 -sha256 -days 365 -nodes \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=melsahha.42.fr"

COPY ./nginx.conf /etc/nginx/http.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
