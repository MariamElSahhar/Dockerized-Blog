#!/bin/bash

# Start MySQL service
service mysql start

# Wait for MySQL service to start
while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

# Create database if it doesn't exist
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

# Create user and grant privileges
mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

# Change root user password (if needed)
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Flush privileges
mysql -e "FLUSH PRIVILEGES;"

# Shutdown MySQL service
service mysql stop

# Execute CMD or ENTRYPOINT command
exec "$@"
