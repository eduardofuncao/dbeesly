start:
	docker compose up -d
	@echo "MySQL started. Connection string: mysql://myuser:mypassword@localhost:3306/mydb"
	@echo "pam init mysql-docker mysql \"myuser:mypassword@tcp(127.0.0.1:3306)/mydb\""

stop:
	docker compose down
	@echo "MySQL stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "MySQL stopped and volumes removed."
