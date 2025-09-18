{
  description =
    "A Nix-flake-based Rust development environment (multi-system, flake-utils)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
  };

  outputs = { nixpkgs, flake-utils, naersk, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naerskLib = pkgs.callPackage naersk { };
      in {
        packages.default = naerskLib.buildPackage {
          src = ./.;
          buildInputs = with pkgs; [ openssl ];
          nativeBuildInputs = [ pkgs.pkg-config ];
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustc
            cargo
            clippy
            rustfmt
            openssl
            rust-analyzer
          ];
          nativeBuildInputs = [ pkgs.pkg-config ];
        };
        formatter = pkgs.rustfmt;
      });
}
