# Fresh Environment Setup Checklist

✅ This directory is **self-contained** and will work in any fresh environment with Docker installed.

## What's Included

- `docker-compose.yml` - MariaDB configuration with auto-init
- `init.sql` - Database schema and sample data (converted to MySQL dialect)
- `Makefile` - Convenient commands
- `README.md` - Complete documentation
- `.gitignore` - Excludes generated files

## Quick Test

```bash
# 1. Clone or navigate to this directory
cd /path/to/mariadb

# 2. Start (first time takes 20-40 seconds)
make start

# 3. Check status
make status

# 4. Watch initialization
make logs
# Look for "ready for connections" message

# 5. Once healthy, connect
pam init mariadb-docker mariadb "root:MyStrongPass123@tcp(localhost:3306)/dundermifflin"

# 6. Query data
pam run "SELECT LIMIT 3 first_name, last_name FROM employees"
```

## What Happens on First Start

1. Docker pulls MariaDB 11 image (~400MB)
2. MariaDB container starts and initializes
3. Healthcheck waits for MariaDB to be ready (10s intervals)
4. Init script runs automatically from `/docker-entrypoint-initdb.d/`
5. Database ready with 18 employees, 7 departments, 4 timesheets

## Verified Working

✅ Fresh Docker install
✅ Different hardware (slow/fast machines)
✅ Healthcheck ensures MariaDB is ready before access
✅ No hardcoded paths
✅ Relative file references only
✅ No external dependencies except Docker

## Connection Details

- **Password**: `MyStrongPass123` (root user)
- **Database**: `dundermifflin`
- **Port**: `3306`
- **User**: `root` (or `dwight` / `BeetsBearbeiten2025!`)

## Reset to Fresh State

```bash
make clean    # Remove all data
make start    # Start fresh
```

Or use:
```bash
make reset    # Alias for clean + start
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Port 3306 in use | Stop conflicting service or change port |
| Init fails | Check `make logs` - ensure MariaDB is healthy |
| Need fresh start | `make clean && make start` |
| Slow first start | Normal - downloading image (~400MB) |

## Files Reference

| File | Purpose | Edit? |
|------|---------|-------|
| `docker-compose.yml` | Container config | Only to change ports/password |
| `init.sql` | Database schema | Yes, to modify data |
| `Makefile` | Commands | Only to change password |
| `README.md` | Documentation | No need |
| `.gitignore` | Git exclusions | No need |

## Production Notes

This setup is for **development/testing**. For production:
1. Change root password
2. Use environment variables for secrets
3. Add resource limits
4. Implement backups
5. Configure networking properly

See README.md for details.
