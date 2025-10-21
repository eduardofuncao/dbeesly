#!/bin/sh
docker compose up -d
echo "Postgres connection string: postgres://myuser:mypassword@localhost:5432/mydb?sslmode=disable"
echo "pam init postgres-docker postgres postgres://myuser:mypassword@localhost:5432/mydb?sslmode=disable"
