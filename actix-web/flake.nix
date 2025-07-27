{
  description = "A Nix-flake-based actix-web development environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodejs
          rustc
          cargo
          clippy
          rustfmt
          openssl
          rust-analyzer
          pkg-config

          yarn
          pnpm
          # nodePackages.typescript
          nodePackages.eslint
          nodePackages.prettier
          nodePackages.typescript-language-server
        ];

        shellHook = ''
          export RUST_SRC_PATH=${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}
        '';
      };
    };
}
