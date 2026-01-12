# Fresh Environment Setup

This directory contains ClickHouse database setup.

## Quick Setup

```bash
# 1. Start the database (one-time setup)
make start

# 2. Wait for database to be healthy (check with: make status)
# Usually takes 20-30 seconds

# 3. Connect with pam (once driver is added)
pam init clickhouse-docker clickhouse "clickhouse://default:BeetsBearbeiten2025!@localhost:9000?database=dundermifflin"
```

## Connection String

```
clickhouse://default:BeetsBearbeiten2025!@localhost:9000?database=dundermifflin
```

**Parameters:**
- **User**: default
- **Password**: BeetsBearbeiten2025!
- **Host**: localhost
- **Port**: 9000 (Native protocol)
- **Database**: dundermifflin

## Notes

- **OLAP Database** - Optimized for analytics, not transactions
- **Healthcheck** - Wait for container to be healthy before connecting
- **Auto-init** - Database schema is created automatically on first start
- **Persistent** - Data stored in Docker volume

## Reset Database

```bash
make clean    # Stop and remove volumes
make start    # Start with fresh database
```

## Verification

```bash
# Check container status
make status

# View logs
make logs
```

Expected output: Container should show status "healthy" after 20-30 seconds.
