# MariaDB Docker Setup

A Docker Compose setup for MariaDB 11 with an automated initialization script. This includes "The Office" themed sample database for testing and development.

## Features

- ✅ MariaDB 11 (drop-in replacement for MySQL)
- ✅ Automated database initialization with healthchecks
- ✅ Sample schema: departments, employees, timesheets
- ✅ Reliable startup - waits for MariaDB to be actually ready
- ✅ Works on any machine with Docker installed
- ✅ Automatic init script execution (no separate init container needed)

## Quick Start

### Prerequisites

- Docker Desktop or Docker Engine installed
- `make` command (or use `docker compose` directly)

### Start the Database

```bash
# Clone or cd to this directory
cd /path/to/mariadb

# Start MariaDB (will initialize automatically)
make start

# Watch the logs to see initialization progress
make logs

# Check status
make status
```

### Wait for Initialization

The database will take **20-40 seconds** to initialize on first start. You'll see:

```
✓ MariaDB is starting...
  Wait for the database to initialize (check with: make logs)
```

Check logs to see when it's done:
```bash
make logs
```

### Connect with [pam](https://github.com/eduardofuncao/pam)

Once MariaDB is healthy, connect:

```bash
# Initialize connection
pam init mariadb-docker mariadb "root:MyStrongPass123@tcp(localhost:3306)/dundermifflin"

# Run queries
pam run "SELECT TOP 5 * FROM employees"
pam run "SELECT * FROM departments"

# Save a query
pam add employees "SELECT * FROM employees ORDER BY last_name LIMIT 10"
pam run employees
```

### Connect Directly with mysql CLI

```bash
# From the MariaDB container
docker exec -it mariadb-mariadb-1 mysql -u root -p'MyStrongPass123' dundermifflin

# From your machine (if you have mysql client installed)
mysql -h 127.0.0.1 -P 3306 -u root -p'MyStrongPass123' dundermifflin
```

## Database Schema

### Tables

1. **departments** (7 rows)
   - Dunder Mifflin branches and teams
   - Columns: id, name, location, budget, head_count, metadata

2. **employees** (18 rows)
   - The Office characters with detailed profiles
   - Columns: id, first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, skills, performance_rating

3. **timesheets** (4 rows)
   - Sample timesheet entries
   - Columns: id, employee_id, task_name, date_worked, hours_worked, description, billable, tags

### Sample Queries

```sql
-- Top sales performers
SELECT e.first_name, e.last_name, e.performance_rating, d.name as department
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.name = 'Sales'
ORDER BY e.performance_rating DESC
LIMIT 5;

-- Department budget summary
SELECT name, location, budget, head_count,
       budget / NULLIF(head_count, 0) as budget_per_person
FROM departments
ORDER BY budget DESC;

-- Recent timesheet entries
SELECT e.first_name, e.last_name, t.task_name, t.date_worked, t.hours_worked
FROM timesheets t
JOIN employees e ON t.employee_id = e.id
ORDER BY t.date_worked DESC
LIMIT 10;
```

## Make Commands

| Command | Description |
|---------|-------------|
| `make start` | Start MariaDB and initialize database |
| `make stop` | Stop MariaDB (keeps data) |
| `make logs` | Follow Docker Compose logs |
| `make status` | Show container status |
| `make clean` | Stop and remove all data (fresh start) |
| `make reset` | Clean and restart (like `make clean start`) |

## Connection Details

- **Host**: `localhost`
- **Port**: `3306`
- **Root User**: `root`
- **Root Password**: `MyStrongPass123`
- **Database**: `dundermifflin`
- **Additional User**: `dwight` / `BeetsBearbeiten2025!`
- **Connection String**: `root:MyStrongPass123@tcp(localhost:3306)/dundermifflin`

## How It Works

### Reliable Initialization

This setup uses Docker healthchecks and MariaDB's built-in init script execution:

1. **mariadb** service starts
2. Healthcheck runs every 10s using built-in `healthcheck.sh`
3. MariaDB automatically executes `/docker-entrypoint-initdb.d/init.sql` on first startup
4. Database is ready to use!

This approach:
- ✅ No arbitrary `sleep 30` timeouts
- ✅ Works reliably on different hardware
- ✅ Proper error handling if MariaDB fails to start
- ✅ Observable health status with `docker compose ps`
- ✅ Simpler than SQL Server (no separate init container needed)

### Files

- **docker-compose.yml**: Defines MariaDB service
- **init.sql**: Database schema and sample data
- **Makefile**: Convenient commands
- **.gitignore**: Excludes Docker volumes and temp files

## Troubleshooting

### Port 3306 already in use

```bash
# Check what's using port 3306
lsof -i :3306  # macOS/Linux
netstat -ano | findstr :3306  # Windows

# Stop the conflicting service or change the port in docker-compose.yml
```

### Healthcheck failing

Check the logs:
```bash
docker compose logs mariadb
```

Common issues:
- Not enough memory (MariaDB needs at least 512MB)
- Password incorrect
- Port conflicts

### Reset everything

```bash
make clean
make start
```

This removes all volumes and starts fresh.

## Development

### Modifying the Schema

1. Edit `init.sql`
2. Run `make reset` (removes old database and creates new one)

### Adding More Sample Data

Edit `init.sql` and add more INSERT statements, then reset.

## Production Considerations

This setup is for **development/testing only**. For production:

1. **Change the root password** - Use a strong, unique password
2. **Use environment variables** - Never commit passwords
3. **Add backups** - Implement MariaDB backup strategy
4. **Configure networking** - Don't expose ports publicly
5. **Add resource limits** - Set CPU/memory limits in docker-compose.yml
6. **Use secrets** - Use Docker secrets or Vault for credentials

Example environment variables approach:
```yaml
services:
  mariadb:
    environment:
      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/root_password
    secrets:
      - root_password
```

## SQL Dialect Notes

This MariaDB setup uses standard MySQL/MariaDB SQL syntax:

- **AUTO_INCREMENT** instead of IDENTITY
- **VARCHAR** instead of NVARCHAR (UTF-8 by default)
- **TINYINT(1)** instead of BIT for booleans
- **LIMIT** instead of TOP
- Standard FOREIGN KEY constraints

## License

MIT

## Credits

- MariaDB Docker image by MariaDB Foundation
- Sample database inspired by "The Office" (US)
