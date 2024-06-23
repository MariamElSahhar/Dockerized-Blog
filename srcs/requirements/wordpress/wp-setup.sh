#!/bin/bash

# until mysqladmin ping -h mariadb --silent; do
#     echo "Waiting for MariaDB to start..."
#     sleep 5
# done
sleep 10
set -e

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
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --dbprefix=$DB_PREFIX --skip-check --allow-root

# Install WordPress (optional)
wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --skip-email --allow-root

# Update PHP-FPM configuration to listen on port 9000
sed -i 's|listen = .*|listen = 9000|' /etc/php/php-fpm.d/www.conf

# Create the run directory for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM
php-fpm -F
