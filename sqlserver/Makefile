start:
	docker compose up -d
	@echo ""
	@echo "✓ SQL Server is starting..."
	@echo "  Wait for the database to initialize (check with: make logs)"
	@echo "  Once healthy, connect with:"
	@echo ""
	@echo "  pam init sqlserver-docker sqlserver \"sqlserver://sa:MyStrongPass123@localhost:1433/master\""
	@echo ""

stop:
	docker compose down
	@echo "✓ SQL Server stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "✓ SQL Server stopped, volumes removed."

status:
	docker compose ps

reset: clean start
	@echo "✓ SQL Server reset with fresh database."

