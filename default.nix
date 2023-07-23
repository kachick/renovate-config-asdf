{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21061e4e4a0f46a6f487c7583be916e4e031ee4e.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs-18_x
    pkgs.crystal
    pkgs.shards
    pkgs.dprint
    pkgs.nil
    pkgs.nixpkgs-fmt
    pkgs.pcre
    pkgs.typos
  ];
}
