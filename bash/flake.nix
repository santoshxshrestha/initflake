{
  description = "A Nix-flake-based Bash development environment for bash";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          bash
          shellcheck
          shfmt
          bash-language-server
          bats
          jq
        ];
        shellHook = ''
          # Bash development environment ready
        '';
      };
    };
}
