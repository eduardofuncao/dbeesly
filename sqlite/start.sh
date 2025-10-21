#!/usr/bin/env bash
set -euo pipefail

# Simple script: build mydb.sqlite from init.sql, then print connection info.

DB_FILE="mydb.sqlite"
INIT_SQL="init.sql"
PROJECT_NAME="sqlite-local"

if [[ ! -f "$INIT_SQL" ]]; then
  echo "Error: $INIT_SQL not found in current directory." >&2
  exit 1
fi

rm -f "$DB_FILE"

sqlite3 "$DB_FILE" <<'SQL'
PRAGMA foreign_keys = ON;
.read 'init.sql'
SQL

DB_PATH="$(cd "$(dirname "$DB_FILE")" && pwd)/$(basename "$DB_FILE")"
CONNECTION_STRING="file:$DB_PATH"


echo "Connection string:"
echo "$CONNECTION_STRING"
echo
echo "pam command:"
echo "pam init $PROJECT_NAME sqlite $CONNECTION_STRING"
