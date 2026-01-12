start:
	docker compose up -d
	@echo ""
	@echo "✓ MariaDB is starting..."
	@echo "  Wait for the database to initialize (check with: make logs)"
	@echo "  Once healthy, connect with:"
	@echo ""
	@echo "  pam init mariadb-docker mariadb \"root:MyStrongPass123@tcp(localhost:3306)/dundermifflin\""
	@echo ""

stop:
	docker compose down
	@echo "✓ MariaDB stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "✓ MariaDB stopped and volumes removed."

status:
	docker compose ps

reset: clean start
	@echo "✓ MariaDB reset with fresh database."
