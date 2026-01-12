#!/usr/bin/env bash
# Alternative initialization script for when Docker has network issues
# Requires DuckDB CLI to be installed locally

# Check if duckdb is installed
if ! command -v duckdb &> /dev/null; then
    echo "❌ DuckDB CLI not found locally."
    echo ""
    echo "Install DuckDB CLI:"
    echo "  # On Linux/macOS:"
    echo "  curl -L https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o /tmp/duckdb.zip"
    echo "  unzip /tmp/duckdb.zip -d /tmp/"
    echo "  sudo mv /tmp/duckdb /usr/local/bin/duckdb"
    echo "  chmod +x /usr/local/bin/duckdb"
    echo ""
    echo "  # Or use Docker (requires network):"
    echo "  make init"
    exit 1
fi

# Create data directory
mkdir -p ./data

# Initialize database
echo "✓ Initializing DuckDB database..."
duckdb ./data/dundermifflin.duckdb <<EOF
.read init.sql
EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ DuckDB database initialized!"
    echo "  Location: ./data/dundermifflin.duckdb"
    echo ""
    echo "  Connect with pam:"
    echo "  pam init duckdb-local duckdb $(pwd)/data/dundermifflin.duckdb"
    echo ""
else
    echo "❌ Failed to initialize database"
    exit 1
fi
