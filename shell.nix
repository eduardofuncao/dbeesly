let
  pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
  oracleLib = pkgs.oracle-instantclient.lib;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Container runtime
    docker
    docker-compose

    # Database clients
    mysql
    postgresql
    sqlite
    oracle-instantclient
    clickhouse

    # Additional useful tools
    jq
  ];

  shellHook = ''
    export ORACLE_HOME=${oracleLib}
    export LD_LIBRARY_PATH=${oracleLib}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

    echo "dbeesly dev environment loaded"
    echo "Available databases: mariadb, postgres, sqlite, oracle, sqlserver, clickhouse, duckdb"
    echo ""
    echo "Usage:"
    echo "  cd <database> && make start"
  '';
}
