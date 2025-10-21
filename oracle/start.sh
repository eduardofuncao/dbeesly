#!/bin/sh
set -e

docker compose up -d

echo "Oracle EZCONNECT: myuser/mypassword@localhost:1521/XEPDB1"
echo "Oracle JDBC: jdbc:oracle:thin:@//localhost:1521/XEPDB1"
echo "pam init oracle-docker oracle myuser/mypassword@localhost:1521/XEPDB1"
