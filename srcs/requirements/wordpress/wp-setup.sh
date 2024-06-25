#!/bin/bash

# until mysqladmin ping -h mariadb --silent; do
#     echo "Waiting for MariaDB to start..."
#     sleep 5
# done
until nc -z -w5 mariadb 3306; do
	echo "Waiting for MariaDB to start..."
	sleep 5
done
echo "MariaDB ponged"

set -e

echo "SETTING UP WP"

# Create necessary directories
mkdir -p /var/www/html

# Navigate to the target directory
cd /var/www/html

# Clean any existing content
rm -rf *

# Download and set up WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core files
wp core download --allow-root
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --skip-check --allow-root

# Install WordPress (optional)
wp core install --url=$DOMAIN_NAME --title="Inception" --admin_user="mariam" --admin_password=$DB_ROOT_PASSWORD --admin_email="mariam@email.com" --skip-email --allow-root

# Update PHP-FPM configuration to listen on port 9000
sed -i 's|listen = .*|listen = 9000|' /etc/php81/php-fpm.d/www.conf
echo "Updated php port"

# Create the run directory for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM
echo "Running php-fpm"
php-fpm81 -F
echo "Done"
sleep 10
