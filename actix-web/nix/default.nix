{ pkgs, openssl, pkg-config, ... }:
pkgs.rustPlatform.buildRustPackage {
  name = "project";
  src = ./.;
  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];
  # cargoHash = pkgs.lib.fakeHash;
  cargoLock.lockFile = ./Cargo.lock;
}
