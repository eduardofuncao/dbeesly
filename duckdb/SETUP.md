# Fresh Environment Setup

✅ This directory contains DuckDB database setup.

## Quick Setup

### Prerequisites

DuckDB CLI must be installed on your system:

**NixOS:**
```bash
nix-shell -p duckdb
# Or add to configuration.nix: environment.systemPackages = [ pkgs.duckdb ];
```

**Linux/macOS:**
```bash
# Download and install
curl -L https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o /tmp/duckdb.zip
unzip /tmp/duckdb.zip -d /tmp/
sudo mv /tmp/duckdb /usr/local/bin/duckdb
chmod +x /usr/local/bin/duckdb
```

### Initialize Database

```bash
# 1. Initialize database (auto-detects local CLI or uses Docker)
make init

# 2. Database file is created at ./data/dundermifflin.duckdb

# 3. Connect with pam (once driver is added)
pam init duckdb duckdb /absolute/path/to/data/dundermifflin.duckdb
```

**Note:** The `make init` command automatically:
- Uses local DuckDB CLI if available (recommended, works on NixOS)
- Falls back to Docker if CLI is not found

## Notes

- **No server needed** - DuckDB is embedded
- **File-based** - Database is a single file
- **One-time init** - Run `make init` once, then use the file directly
- **Clean start** - `make clean` removes database file

## Connection Details

- **Database File**: `./data/dundermifflin.duckdb`
- **Absolute Path Required**: Use full path when connecting with pam

## Reset Database

```bash
make clean    # Remove database file
make init     # Reinitialize
```

## Advanced: Explicit Methods

If you want to explicitly choose the initialization method:

```bash
make init-local   # Force local CLI (requires DuckDB installed)
make init         # Auto-detect: local CLI preferred, Docker fallback
```
