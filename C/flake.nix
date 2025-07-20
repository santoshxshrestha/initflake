{
  description = "A Nix-flake-based C/C++ development environment";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          gcc
          clang
          cmake
          # ninja
          # make
          gdb
          # valgrind
          pkg-config
          clang-tools
        ];
        shellHook = ''
          export CC=gcc
          export CXX=g++
        '';
      };
    };
}
