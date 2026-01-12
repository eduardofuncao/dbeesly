FROM alpine:latest

# Install dependencies and DuckDB CLI
RUN apk add --no-cache \
    bash \
    curl \
    ca-certificates \
    unzip \
    && curl -L --retry 3 --retry-delay 2 https://github.com/duckdb/duckdb/releases/download/v1.1.3/duckdb_cli-linux-amd64.zip -o /tmp/duckdb.zip \
    && unzip /tmp/duckdb.zip -d /tmp/ \
    && mv /tmp/duckdb /usr/local/bin/duckdb \
    && chmod +x /usr/local/bin/duckdb \
    && rm /tmp/duckdb.zip

WORKDIR /data

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "echo 'DuckDB CLI ready. Use: docker compose run --rm duckdb-init'"]
