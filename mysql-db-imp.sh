#!/bin/bash
set -e

echo "Starting MySQL server..."
docker-entrypoint.sh mysqld &  # Start MySQL in the background

# Wait for MySQL to be fully ready
echo "Waiting for MySQL to initialize..."
until mysqladmin ping -h localhost --silent; do
    sleep 2
done

echo "MySQL is up and running!"

# Create the database
echo "Creating database 'carrental'..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE carrental;"

# Import the SQL file
echo "Importing database schema..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" carrental < /docker-entrypoint-initdb.d/carrental.sql

echo "MySQL initialization complete."

# Keep MySQL running in the foreground
wait
