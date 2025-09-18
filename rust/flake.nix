{
  description =
    "A Nix-flake-based Rust development environment (multi-system, flake-utils)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.callPackage ./nix/default.nix { };
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
