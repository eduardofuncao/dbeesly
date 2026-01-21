start:
	docker compose up -d
	@echo "Firebird started. Connection information:"
	@echo "pam init firebird-docker firebird SYSDBA:masterkey@localhost:3050//var/lib/firebird/data/the_office"

stop:
	docker compose down
	@echo "Firebird stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "Firebird stopped and volumes removed."

status:
	docker compose ps

reset: clean start
	@echo "Firebird reset with fresh database."
