# DuckDB Docker Setup

A Docker setup for DuckDB with "The Office" themed sample database. 

**⚠️ Important:** DuckDB is an **embedded analytical database**, not a traditional server-based database like MySQL or PostgreSQL. It's designed for in-process analytics and local file-based queries.

## Features

- ✅ DuckDB (fast analytical OLAP database)
- ✅ Embedded file-based database (no server)
- ✅ Sample schema: departments, employees, timesheets
- ✅ One-time initialization (creates .duckdb file)
- ✅ Perfect for data analysis and analytics workloads

## Quick Start

### Prerequisites

- **DuckDB CLI** (recommended, works on all systems including NixOS)
- OR Docker Desktop/Docker Engine (optional, as fallback)
- `make` command

### Initialize the Database

**Quick Start (Recommended):**

```bash
# Clone or cd to this directory
cd /path/to/duckdb

# Install DuckDB CLI first
# NixOS:
nix-shell -p duckdb

# Linux/macOS:
curl -L https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o /tmp/duckdb.zip
unzip /tmp/duckdb.zip -d /tmp/
sudo mv /tmp/duckdb /usr/local/bin/duckdb
chmod +x /usr/local/bin/duckdb

# Initialize (auto-detects local CLI or uses Docker)
make init
```

This will create `./data/dundermifflin.duckdb` with all the sample data.

**Notes:**
- **NixOS users**: Use `nix-shell -p duckdb` then `make init` (Docker not needed)
- **Other systems**: `make init` auto-detects if DuckDB CLI is installed and uses it, otherwise falls back to Docker
- **Explicit control**: Use `make init-local` to force local CLI
- **Docker alternative**: Docker setup is available but not required (works if CLI is not found)

### Connect with [pam](https://github.com/eduardofuncao/pam)

**DuckDB is now supported in pam!** You can connect directly:

```bash
# Initialize connection (after adding DuckDB driver to pam)
pam init duckdb-local duckdb /absolute/path/to/data/dundermifflin.duckdb

# Run queries
pam run "SELECT * FROM employees LIMIT 5"
pam run "SELECT * FROM departments"

# Save a query
pam add employees "SELECT * FROM employees ORDER BY last_name LIMIT 10"
pam run employees
```

## How DuckDB Differs from Traditional Databases

### Key Differences

1. **No Server Process**
   - Traditional databases run as a server (MySQL, PostgreSQL, etc.)
   - DuckDB is embedded - like SQLite, but for analytics
   - No `make start` / `make stop` - just open the file directly

2. **File-Based Storage**
   - Database is a single file: `dundermifflin.duckdb`
   - Can be copied, backed up, moved like any other file
   - No persistent containers

3. **Analytical Optimizations**
   - Columnar storage (fast aggregations)
   - Optimized for read-heavy analytical workloads
   - Not designed for high-frequency UPDATE/DELETE

4. **In-Memory Capable**
   - Can run entirely in-memory: `:memory:`
   - Perfect for ephemeral analytics
   - Data is lost when process ends

## Database Schema

### Tables

1. **departments** (7 rows)
   - Dunder Mifflin branches and teams
   - Columns: id, name, location, budget, head_count, metadata

2. **employees** (18 rows)
   - The Office characters with detailed profiles
   - Columns: id, first_name, last_name, position, email, phone, date_of_birth, hire_date, salary, office_number, department_id, reports_to, status, favorite_snack, hobby, car, favorite_catchphrase, linkedin_profile, **skills[]**, performance_rating
   - **skills** is a native array type: `['Leadership', 'Comedy']`

3. **timesheets** (4 rows)
   - Sample timesheet entries
   - Columns: id, employee_id, task_name, date_worked, hours_worked, description, billable, **tags[]**
   - **tags** is a native array type: `['meeting', 'sales']`

## Make Commands

| Command | Description |
|---------|-------------|
| `make init` | Initialize database (runs once, creates .duckdb file) |
| `make clean` | Delete database files |
| `make reset` | Reinitialize database from scratch |

## SQL Dialect Notes

DuckDB uses PostgreSQL-like SQL syntax:

- **INTEGER PRIMARY KEY** (no AUTO_INCREMENT - explicit IDs)
- **VARCHAR** (UTF-8 by default)
- **BOOLEAN** instead of BIT/TINYINT(1)
- **LIMIT** (standard SQL)
- **Native arrays**: `VARCHAR[]` instead of JSON strings
- **No FOREIGN KEY constraints** (optional in DuckDB)

## Use Cases for DuckDB

DuckDB is perfect for:

- ✅ **Data analytics** on CSV/Parquet files
- ✅ **In-memory analytical queries**
- ✅ **Data science and exploration**
- ✅ **ETL and data pipelines**
- ✅ **Temporary analytical datasets**

Not ideal for:

- ❌ Transactional applications (CRUD operations)
- ❌ High-concurrency access
- ❌ Long-running server processes
- ❌ Primary database for web applications

## Connection Details

- **Type**: File-based embedded database
- **Database File**: `./data/dundermifflin.duckdb`
- **Connection String**: `/absolute/path/to/data/dundermifflin.duckdb`
- **In-Memory Option**: `:memory:`

## Sample Queries

```sql
-- Analytical queries are DuckDB's strength
SELECT 
    d.name as department,
    COUNT(*) as employee_count,
    AVG(e.performance_rating) as avg_rating,
    SUM(e.salary) as total_salary
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.name
ORDER BY total_salary DESC;

-- Array operations (native support)
SELECT 
    first_name, 
    last_name, 
    UNLIST(skills) as skill  -- Explode arrays
FROM employees
WHERE ARRAY_LENGTH(skills) > 1;

-- Date analysis
SELECT 
    EXTRACT(YEAR FROM hire_date) as year,
    COUNT(*) as hires
FROM employees
GROUP BY year
ORDER BY year;
```

## Troubleshooting

### Docker build fails with network errors

If you see errors like "Could not resolve host: github.com" during Docker build:

**Solution 1**: Use local DuckDB CLI instead
```bash
make init-local
```

**Solution 2**: Check Docker's network configuration
```bash
# Try rebuilding after clearing Docker cache
docker compose build --no-cache
docker compose up
```

**Solution 3**: Install DuckDB CLI locally and skip Docker entirely
```bash
# On Linux/macOS:
curl -L https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o /tmp/duckdb.zip
unzip /tmp/duckdb.zip -d /tmp/
sudo mv /tmp/duckdb /usr/local/bin/duckdb
chmod +x /usr/local/bin/duckdb

# On NixOS:
nix-shell -p duckdb

# Initialize without Docker
make init-local
```

### NixOS-specific: Binary compatibility issues

If you see "Could not start dynamically linked executable" errors on NixOS:

**Solution**: Use Nix to install DuckDB
```bash
# Temporary installation in nix-shell
nix-shell -p duckdb

# Then initialize
make init-local

# Or install permanently in configuration.nix:
# environment.systemPackages = [ pkgs.duckdb ];
```

### Database file doesn't exist

```bash
# Run initialization
make init          # With Docker
make init-local    # Without Docker
```

### Wrong file path

Use absolute paths when connecting with pam:
```bash
# Wrong (relative path may not work)
pam init duckdb duckdb data/dundermifflin.duckdb

# Correct (absolute path)
pam init duckdb duckdb /home/user/code/dbeesly/duckdb/data/dundermifflin.duckdb
```

### Reinitialize from scratch

```bash
make clean
make init          # With Docker
make init-local    # Without Docker
```

## Development

### Modifying the Schema

1. Edit `init.sql`
2. Run `make reset` (deletes and recreates database file)

### Adding More Sample Data

Edit `init.sql` and add more INSERT statements, then reset.

## Production Considerations

This setup is for **development/testing only**. For production:

1. **Access control**: DuckDB has limited authentication
2. **Concurrency**: Single-writer by default
3. **Persistence**: File-based, needs backup strategy
4. **Monitoring**: Different from server-based databases

## Resources

- [DuckDB Official Site](https://duckdb.org/)
- [DuckDB GitHub](https://github.com/duckdb/duckdb)
- [DuckDB Go Driver](https://github.com/duckdb/duckdb-go)

## License

MIT

## Credits

- DuckDB by DuckDB Labs
- Sample database inspired by "The Office" (US)
