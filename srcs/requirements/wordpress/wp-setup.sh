#!/bin/bash

# Exit immediately if a command exits with a non-zero status
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


# Update PHP-FPM configuration to listen on port 9000
sed -i 's|listen = .*|listen = 9000|' /etc/php82/php-fpm.d/www.conf

# Create the run directory for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM
php-fpm82 -F
