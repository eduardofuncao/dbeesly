DB_PATH := $(CURDIR)/mydb.db

start:
	sqlite3 mydb.db < init.sql
	@echo "SQLite DB initialized. Connection: $(DB_PATH)"
	@echo "pam init sqlite sqlite3 $(DB_PATH)"

stop:

stop:
	@echo "SQLite has no server to stop."

logs:
	@echo "SQLite has no logs to show."

clean:
	rm -f $(DB_PATH)
	@echo "SQLite DB removed: $(DB_PATH)"
