{ pkgs, pkg-config, openssl, ... }:
pkgs.rustPlatform.buildRustPackage {
  name = "project";
  src = ../.;
  # cargoLock = ./Cargo.lock;
  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];
  # cargoHash = pkgs.lib.fakeHash;
  cargoLock.lockFile = ../Cargo.lock;
}
