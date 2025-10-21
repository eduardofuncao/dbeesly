let
  pkgs = import <nixpkgs> { config = { allowUnfree = true; }; };
  oracleLib = pkgs.oracle-instantclient.lib;
in
pkgs.mkShell {
  buildInputs = [
    pkgs.oracle-instantclient
  ];

  shellHook = ''
    export ORACLE_HOME=${oracleLib}
    # Escape Bash parameter expansion so Nix doesn't parse it:
    export LD_LIBRARY_PATH=${oracleLib}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
  '';
}
