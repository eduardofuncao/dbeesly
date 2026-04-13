DB_PATH := $(CURDIR)/mydb.db

start:
	duckdb mydb.db < init.sql
	duckdb mydb.db -c "COPY departments TO 'departments.csv' (HEADER); COPY employees TO 'employees.csv' (HEADER); COPY timesheets TO 'timesheets.csv' (HEADER); COPY departments TO 'departments.json' (FORMAT JSON); COPY employees TO 'employees.json' (FORMAT JSON); COPY timesheets TO 'timesheets.json' (FORMAT JSON);"
	@echo "DuckDB initialized. DB: $(DB_PATH)"
	@echo "Exports: *.csv, *.json"
	@echo "squix init duckdb-local duckdb $(DB_PATH)"

stop:
	@echo "DuckDB has no server to stop."

logs:
	@echo "DuckDB has no logs to show."

clean:
	rm -f $(DB_PATH) *.csv *.json
	@echo "DuckDB files removed."
