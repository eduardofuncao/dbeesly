<div align="center">

<h1>
  dbeesly
  <img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/d64acccb-5db1-4bae-a7e6-132cdc4fa0a8" />
</h1>


### *"Dunder Mifflin, this is Pam."*


> **Michael Scott:** "I love the people of Dunder Mifflin. And I love their
> data. Having all this information about employees, departments, timesheets...
> it's like having a legally bound window into their souls.

---

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
![Docker badge](https://img.shields.io/badge/Docker-supported-2496ED?logo=docker&logoColor=white)

**Multi-database runnable containers with sample data setup for development and testing**

[Quick Start](#-quick-start) • [Supported Databases](#-supported-databases) • [Schema](#-schema) • [Commands](#-commands) • [Development](#-development)

</div>


> Note: All databases are pre-configured for local development with default credentials. **Not for production use.**

---

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose installed

### Basic Usage

```bash
# Start MariaDB (default choice)
cd mariadb && make start

# View logs and wait for initialization
make logs

# Stop the database
make stop

# Clean up containers and data
make clean
```

### Connect with your favorite database tool

```bash
# Using pam
pam init dbeesly-mysql mysql 'root:myrootpassword@tcp(127.0.0.1:3306)/dundermifflin'
pam run "SELECT * FROM employees"

# Using mysql client
mysql -h 127.0.0.1 -P 3306 -u root -pmyrootpassword dundermifflin

# Using psql (PostgreSQL)
psql postgresql://postgres:myrootpassword@localhost:5432/dundermifflin
```

---

## 🗄️ Supported Databases

Each database comes with identical schema and sample data. Pick your flavor:

### MariaDB / MySQL
```bash
cd mariadb && make start
# Connection: mysql://root:myrootpassword@localhost:3306/dundermifflin
```

### PostgreSQL
```bash
cd postgres && make start
# Connection: postgresql://postgres:myrootpassword@localhost:5432/dundermifflin
```

### SQLite
```bash
cd sqlite && make start
# Connection: file:sqlite/dundermifflin.sqlite
```

### Oracle Database
```bash
cd oracle && make start
# Connection: oracle://system:MyStrongPass123@localhost:1521/XEPDB1
```

### SQL Server
```bash
cd sqlserver && make start
# Connection: sqlserver://sa:MyStrongPass123@localhost:1433/dundermifflin
```

### ClickHouse
```bash
cd clickhouse && make start
# Connection: clickhouse://default:@localhost:8123/dundermifflin
```

### DuckDB
```bash
cd duckdb && make start
# Connection: file:duckdb/dundermifflin.duckdb
```

---

## 📋 Schema

All databases share the same **Dunder Mifflin** company structure:

### Tables

**departments** - Company organization

**employees** - Staff records

**timesheets** - Work hours tracking

### Sample Data

```sql
-- Quick peek at the staff
SELECT e.first_name, e.last_name, d.name as department
FROM employees e
JOIN departments d ON e.department_id = d.id
LIMIT 5;

-- Returns:
-- Michael | Scott   | Management
-- Dwight  | Schrute | Sales
-- Jim     | Halpert | Sales
-- Pam     | Beesly  | Reception
-- Ryan    | Howard  | Sales
```

---

## 🛠️ Commands

Each database directory has a Makefile with these commands:

| Command | Description |
|---------|-------------|
| `make start` | Start database container and initialize with sample data |
| `make stop` | Stop running container |
| `make logs` | Show container logs (follow mode) |
| `make clean` | Remove container and delete all data |

### Example Workflow

```bash
cd postgres

# Start fresh
make reset

# Check logs to verify initialization
make logs

# In another terminal, connect and query
psql postgresql://postgres:myrootpassword@localhost:5432/dundermifflin

# When done, clean up
make clean
```

---

## 💻 Development

### NixOS Support
To Enter a nix shell with all necessary binaries and drivers, run `nix-shell` in the root directory

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details
