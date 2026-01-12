# ClickHouse Docker Setup

This directory contains a Docker Compose setup for running ClickHouse with the "The Office" themed sample database.

## About ClickHouse

ClickHouse is a high-performance columnar OLAP database management system. It's designed for analytical workloads and large-scale data processing.

## Quick Start

```bash
# Start the database
make start

# Check logs (wait for "ready for connections")
make logs

# Connect with pam (once database is healthy)
pam init clickhouse-docker clickhouse "clickhouse://default:BeetsBearbeiten2025!@localhost:9000?database=dundermifflin"
```

## Makefile Commands

- `make start` - Start ClickHouse container
- `make stop` - Stop ClickHouse container
- `make logs` - View container logs
- `make status` - Check container status
- `make clean` - Stop and remove volumes (deletes data)
- `make reset` - Clean start with fresh database

## Connection Details

- **Host**: localhost
- **Port (Native)**: 9000
- **Port (HTTP)**: 8123
- **Database**: dundermifflin
- **User**: default
- **Password**: BeetsBearbeiten2025!
- **Driver**: clickhouse (when using pam)

## Database Schema

The database includes three tables:

- **departments** - Company departments with budgets
- **employees** - Employee records (18 employees)
- **timesheets** - Sample time tracking data

### ClickHouse-Specific Features

- Uses **MergeTree** engine (optimized for analytics)
- **Partitioning** by year/month for faster queries
- **Columnar storage** for efficient aggregations
- **Native arrays** for skills and tags
- **No foreign keys** (typical for OLAP databases)
- **Explicit IDs** (no auto-increment)

## Health Check

The container includes a healthcheck that runs every 10 seconds. Wait for the container to be `healthy` before connecting:

```bash
docker compose ps  # Status should show "healthy"
```

## Data Persistence

Data is stored in a Docker volume named `clickhousedata`. Use `make clean` to remove all data.

## Troubleshooting

### Container won't start healthy
```bash
# Check logs
make logs

# Restart
make reset
```

### Connection refused
Make sure the container is healthy before connecting:
```bash
make status
```

### Port already in use
If port 9000 or 8123 is already in use, edit the `ports` section in `docker-compose.yml`.

## Architecture Notes

ClickHouse is different from traditional OLTP databases:
- Optimized for **read-heavy analytical queries**
- **Not ideal** for transactional workloads
- **No UPDATE/DELETE** support in older versions (limited in newer)
- Excellent for **aggregations** and **analytics**
- Best for **append-only** data with **bulk inserts**

## Resources

- [ClickHouse Documentation](https://clickhouse.com/docs)
- [ClickHouse Go Driver](https://github.com/ClickHouse/clickhouse-go)
