# SQL Server Docker Setup

A Docker Compose setup for SQL Server 2022 with an automated initialization script. This includes "The Office" themed sample database for testing and development.

## Features

- ✅ SQL Server 2022 Developer Edition (free)
- ✅ Automated database initialization with healthchecks
- ✅ Sample schema: departments, employees, timesheets
- ✅ Reliable startup - waits for SQL Server to be actually ready
- ✅ Works on any machine with Docker installed

## Quick Start

### Prerequisites

- Docker Desktop or Docker Engine installed
- `make` command (or use `docker compose` directly)

### Start the Database

```bash
# Clone or cd to this directory
cd /path/to/sqlserver

# Start SQL Server (will initialize automatically)
make start

# Watch the logs to see initialization progress
make logs

# Or check status
make status
```

### Wait for Initialization

The database will take **30-90 seconds** to initialize on first start. You'll see:

```
✓ SQL Server is starting...
  Wait for the database to initialize (check with: make logs)
```

Check logs to see when it's done:
```bash
make logs
```

Look for lines like `(1 rows affected)` - that means the init script is running.

### Connect with [pam](https://github.com/eduardofuncao/pam)

Once SQL Server is healthy, connect:

```bash
# Initialize connection
pam init sqlserver-docker sqlserver "sqlserver://sa:MyStrongPass123@localhost:1433/master"

# Run queries
pam run "SELECT TOP 5 * FROM employees"
pam run "SELECT * FROM departments"

# Save a query
pam add employees "SELECT TOP 10 id, first_name, last_name, position FROM employees"
pam run employees
```

### Connect Directly with sqlcmd

```bash
# From the SQL Server container
docker exec -it sqlserver-sqlserver-1 /opt/mssql-tools18/bin/sqlcmd \
  -S localhost -U sa -P 'MyStrongPass123' -C

# From your machine (if you have mssql-tools installed)
sqlcmd -S localhost,1433 -U sa -P 'MyStrongPass123' -C
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
SELECT TOP 5 e.first_name, e.last_name, e.performance_rating, d.name as department
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.name = 'Sales'
ORDER BY e.performance_rating DESC;

-- Department budget summary
SELECT name, location, budget, head_count,
       CAST(budget AS DECIMAL(10,2)) / NULLIF(head_count, 0) as budget_per_person
FROM departments
ORDER BY budget DESC;

-- Recent timesheet entries
SELECT TOP 10 e.first_name, e.last_name, t.task_name, t.date_worked, t.hours_worked
FROM timesheets t
JOIN employees e ON t.employee_id = e.id
ORDER BY t.date_worked DESC;
```

## Make Commands

| Command | Description |
|---------|-------------|
| `make start` | Start SQL Server and initialize database |
| `make stop` | Stop SQL Server (keeps data) |
| `make logs` | Follow Docker Compose logs |
| `make status` | Show container status |
| `make clean` | Stop and remove all data (fresh start) |
| `make reset` | Clean and restart (like `make clean start`) |

## Connection Details

- **Host**: `localhost`
- **Port**: `1433`
- **User**: `sa`
- **Password**: `MyStrongPass123`
- **Database**: `master`
- **Connection String**: `sqlserver://sa:MyStrongPass123@localhost:1433/master`

## How It Works

### Reliable Initialization

This setup uses Docker healthchecks to ensure SQL Server is actually ready before running the init script:

1. **sqlserver** service starts
2. Healthcheck runs every 10s: `/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -Q 'SELECT 1'`
3. Once healthcheck passes → **sqlserver-init** service starts
4. Init service runs `init.sql` and exits
5. Database is ready to use!

This approach:
- ✅ No arbitrary `sleep 30` timeouts
- ✅ Works reliably on different hardware
- ✅ Proper error handling if SQL Server fails to start
- ✅ Observable health status with `docker compose ps`

### Files

- **docker-compose.yml**: Defines SQL Server and init services
- **init.sql**: Database schema and sample data
- **Makefile**: Convenient commands
- **.gitignore**: Excludes Docker volumes and temp files

## Troubleshooting

### Port 1433 already in use

```bash
# Check what's using port 1433
lsof -i :1433  # macOS/Linux
netstat -ano | findstr :1433  # Windows

# Stop the conflicting service or change the port in docker-compose.yml
```

### Healthcheck failing

Check the logs:
```bash
docker compose logs sqlserver
```

Common issues:
- Not enough memory (SQL Server needs at least 2GB)
- Password incorrect
- Port conflicts

### Init container exits immediately

This is normal! The init container:
1. Waits for SQL Server to be healthy
2. Runs `init.sql`
3. Exits successfully

You can verify it worked:
```bash
docker compose logs sqlserver-init | grep "rows affected"
```

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

1. **Change the SA password** - Use a strong, unique password
2. **Use environment variables** - Never commit passwords
3. **Add backups** - Implement SQL Server backup strategy
4. **Configure networking** - Don't expose ports publicly
5. **Add resource limits** - Set CPU/memory limits in docker-compose.yml
6. **Use secrets** - Use Docker secrets or Vault for credentials

Example environment variables approach:
```yaml
services:
  sqlserver:
    environment:
      SA_PASSWORD_FILE: /run/secrets/sa_password
    secrets:
      - sa_password
```

## License

MIT

## Credits

- SQL Server Docker image by Microsoft
- Sample database inspired by "The Office" (US)
