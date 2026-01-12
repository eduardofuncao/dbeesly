start:
	docker compose up -d
	@echo "Oracle started. Connection string: oracle://myuser:mypassword@localhost:1521/XE"
	@echo "pam init oracle-docker oracle my_user/mypassword@localhost:1521/FREEPDB1"

stop:
	docker compose down
	@echo "Oracle stopped."

logs:
	docker compose logs -f

clean:
	docker compose down -v
	@echo "Oracle stopped and volumes removed."
