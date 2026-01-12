start:
	docker compose up -d
	@echo ""
	@echo "✓ ClickHouse is starting..."
	@echo "  Wait for the database to initialize (check with: make logs)"
	@echo "  Once healthy, connect with:"
	@echo ""
	@echo "  pam init clickhouse-docker clickhouse \"clickhouse://dwight:BeetsBearbeiten2025!@localhost:9000/dundermifflin\""
	@echo ""

stop:
	docker compose down
	@echo "✓ ClickHouse stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "✓ ClickHouse stopped and volumes removed."

status:
	docker compose ps

reset: clean start
	@echo "✓ ClickHouse reset with fresh database."
