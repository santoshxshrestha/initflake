{
  description = "A Nix-flake-based actix-web development environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # pkgs = import nixpkgs { inherit system; };
      pkgs = nixpkgs.legacyPackages.${system};

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

          yarn
          pnpm
          # nodePackages.typescript
          nodePackages.eslint
          nodePackages.prettier
          nodePackages.typescript-language-server
        ];
        packages."${system}".default = pkgs.rustPlatform.buildRustPackage {
          name = "project";
          src = ./.;
          # cargoLock = ./Cargo.lock;
          buildInputs = with pkgs; [ openssl ];
          nativeBuildInputs = [ pkgs.pkg-config ];
          # cargoHash = pkgs.lib.fakeHash;
          cargoLock.lockFile = ./Cargo.lock;
        };

        nativeBuildInputs = [ pkgs.pkg-config ];

        env.RUST_SRC_PATH =
          "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    };
}
