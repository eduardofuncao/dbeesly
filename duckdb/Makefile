# Smart init: Try local CLI first (works on NixOS), fall back to Docker
init:
	@if command -v duckdb >/dev/null 2>&1; then \
		./init-local.sh; \
	else \
		echo "⚠️  DuckDB CLI not found locally. Trying Docker..."; \
		docker compose up --remove-orphans; \
		echo ""; \
		echo "✓ DuckDB database initialized!"; \
		echo "  Location: ./data/dundermifflin.duckdb"; \
		echo ""; \
		echo "  Connect with pam:"; \
		echo "  pam init duckdb-local duckdb /home/user/code/dbeesly/duckdb/data/dundermifflin.duckdb"; \
		echo ""; \
	fi

# Explicit: Initialize without Docker (requires local DuckDB CLI)
init-local:
	./init-local.sh

clean:
	rm -rf ./data
	@echo "✓ Database files removed."

reset: clean init
	@echo "✓ DuckDB database reset."

reset-local: clean init-local
	@echo "✓ DuckDB database reset (local)."
