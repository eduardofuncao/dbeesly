#!/bin/bash

docker-compose up -d

# Print the MySQL connection string
echo "myuser:mypassword@tcp(127.0.0.1:3306)/mydb"
echo "pam init mysql-docker mysql 'myuser:mypassword@tcp(127.0.0.1:3306)/mydb'"
