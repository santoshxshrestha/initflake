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
          # clang-tools should come before the clang I read it some where
          # the clang does not matters because you will ditch it for the gcc or g++ I know 
          clang-tools
          clang
          gcc
          cmake
          # ninja
          # make
          gdb
          # valgrind
          pkg-config
          bear
        ];
        shellHook = ''
          export CC=gcc
          export CXX=g++
        '';
      };
    };
}
