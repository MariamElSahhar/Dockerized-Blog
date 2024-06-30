#!/bin/bash

until nc -z -w5 mariadb 3306; do
	echo "Waiting for MariaDB to start..."
	sleep 5
done
echo "MariaDB ponged"

set -e

echo "SETTING UP WP"

mkdir -p /var/www/html
cd /var/www/html
rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --skip-check --allow-root

wp core install --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

chmod -R 777 /var/www/html/

if ! wp user get $WP_USER --field=ID --allow-root >/dev/null 2>&1; then
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root
fi

sed -i 's|listen = .*|listen = 9000|' /etc/php81/php-fpm.d/www.conf
echo "Updated php port"

mkdir -p /run/php
chmod -R 777 /var/www/html/

echo "Running php-fpm"
php-fpm81 -F
echo "Done"
