start:
	docker compose up -d
	@echo "Postgres started. Connection string: postgres://myuser:mypassword@localhost:5432/mydb?sslmode=disable"
	@echo "pam init postgres-docker postgres postgres://myuser:mypassword@localhost:5432/mydb?sslmode=disable"

stop:
	docker compose down
	@echo "Postgres stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "Postgres stopped and volumes removed."
