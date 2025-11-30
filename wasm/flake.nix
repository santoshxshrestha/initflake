{
  description = "A nix flake for wasm projects in rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    naersk.url = "github:nix-community/naersk";
  };

  outputs =
    { nixpkgs, naersk, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      naerskLib = pkgs.callPackage naersk { };
    in
    {
      packages.${system}.default = naerskLib.buildPackage {
        src = ./.;
        buildInputs = [ pkgs.openssl ];
        nativeBuildInputs = [ pkgs.pkg-config ];
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          rustc
          cargo
          rust-analyzer
          clippy
          cargo-watch
          rustfmt

          nodejs
          pnpm
          nodePackages.typescript
          nodePackages.eslint
          nodePackages.prettier
          nodePackages.typescript-language-server

          wasm-pack
          rocmPackages.llvm.lld
        ];

        nativeBuildInputs = [ pkgs.pkg-config ];

      };
      formatter = [
        pkgs.rustfmt
        pkgs.prettier
      ];

    };
}
