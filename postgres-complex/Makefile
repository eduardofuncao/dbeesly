start:
	docker compose up -d
	@echo "Postgres Complex started. Connection string: postgres://myuser:mypassword@localhost:5433/mydb?sslmode=disable"
	@echo "squix init postgres-complex postgres postgres://myuser:mypassword@localhost:5433/mydb?sslmode=disable"

stop:
	docker compose down
	@echo "Postgres Complex stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "Postgres Complex stopped and volumes removed."
