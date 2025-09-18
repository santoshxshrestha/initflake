{
  description =
    "A Nix-flake-based actix-web development environment (multi-system, flake-utils)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
  };

  outputs = { nixpkgs, flake-utils, naersk, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        naerskLib = pkgs.callPackage naersk { };
      in {
        packages.default = naerskLib.buildPackage {
          src = ./.;
          buildInputs = with pkgs; [ openssl ];
          nativeBuildInputs = [ pkgs.pkg-config ];
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs
            rustc
            cargo
            clippy
            rustfmt
            openssl
            rust-analyzer

            yarn
            pnpm
            # nodePackages.typescript
            nodePackages.eslint
            nodePackages.prettier
            nodePackages.typescript-language-server
          ];

          formatter = pkgs.rustfmt;

          nativeBuildInputs = [ pkgs.pkg-config ];

          env.RUST_SRC_PATH =
            "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
        };
      });
}
