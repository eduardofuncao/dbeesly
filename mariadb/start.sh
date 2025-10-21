#!/bin/sh
set -e

docker compose up -d

echo "MariaDB is starting. It may take a few seconds to become ready."
echo ""
echo "Connection strings:"
echo "  MySQL URI:  mysql://myuser:mypassword@localhost:3306/mydb?parseTime=true&charset=utf8mb4"
echo "  Go DSN:     myuser:mypassword@tcp(localhost:3306)/mydb?parseTime=true&charset=utf8mb4"
echo "  CLI:        mysql -h 127.0.0.1 -P 3306 -u myuser -p mydb"
echo ""
echo "pam init example:"
echo "  pam init mariadb-docker mysql 'myuser:mypassword@tcp(localhost:3306)/mydb?parseTime=true&charset=utf8mb4'"
