{
  description = "flake for generating proto msgs and nanopb lib from that proto";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ...}@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ] (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      nanopb_runner = pkgs.writeShellScriptBin "run-nanopb" ''
        #!${pkgs.stdenv.shell}
        export PATH="${pkgs.protobuf}/bin:$PATH"
        generate_header() {
          local version_string=$1
          echo "#ifndef ESTIMATION_MSGS_VERSION_H" > estimation_msgs_version.h
          echo "#define ESTIMATION_MSGS_VERSION_H" >> estimation_msgs_version.h
          echo "const char *version = \"$version_string\";" >> estimation_msgs_version.h
          echo "#endif" >> estimation_msgs_version.h
        }

        if [ "$#" -gt 0 ]; then
          generate_header "$1"
        fi
        ${pkgs.nanopb}/bin/nanopb_generator.py -I=./proto estimation_msgs.proto
      '';
    in
    {
      packages = rec {
        nanopbRunner = nanopb_runner;
      };
      apps = {
        nanopb-runner = flake-utils.lib.mkApp {
          drv = nanopb_runner;
        };
      };

    });
}