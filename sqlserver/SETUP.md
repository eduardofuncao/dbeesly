# Fresh Environment Setup Checklist

✅ This directory is **self-contained** and will work in any fresh environment with Docker installed.

## What's Included

- `docker-compose.yml` - SQL Server + init configuration
- `init.sql` - Database schema and sample data
- `Makefile` - Convenient commands
- `README.md` - Complete documentation
- `.gitignore` - Excludes generated files

## Quick Test

```bash
# 1. Clone or navigate to this directory
cd /path/to/sqlserver

# 2. Start (first time takes 30-90 seconds)
make start

# 3. Check status
make status

# 4. Watch initialization
make logs
# Look for "(1 rows affected)" messages

# 5. Once healthy, connect
pam init sqlserver-docker sqlserver "sqlserver://sa:MyStrongPass123@localhost:1433/master"

# 6. Query data
pam run "SELECT TOP 3 first_name, last_name FROM employees"
```

## What Happens on First Start

1. Docker pulls SQL Server 2022 image (~1.5 GB)
2. SQL Server container starts and initializes
3. Healthcheck waits for SQL Server to be ready (10s intervals)
4. Init container runs `init.sql` automatically
5. Database ready with 18 employees, 7 departments, 4 timesheets

## Verified Working

✅ Fresh Docker install
✅ Different hardware (slow/fast machines)
✅ Healthcheck ensures SQL Server is ready before init
✅ No hardcoded paths
✅ Relative file references only
✅ No external dependencies except Docker

## Connection Details

- **Password**: `MyStrongPass123` (changed from `MyStrongPass123!`)
- **Database**: `master`
- **Port**: `1433`
- **User**: `sa`

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
| Port 1433 in use | Stop conflicting service or change port |
| Init fails | Check `make logs` - ensure SQL Server is healthy |
| Need fresh start | `make clean && make start` |
| Slow first start | Normal - downloading image (~1.5GB) |

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
1. Change SA password
2. Use environment variables for secrets
3. Add resource limits
4. Implement backups
5. Configure networking properly

See README.md for details.
