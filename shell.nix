{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/91c11d19e7007d768dff5d74daf2e6d704aeeebf.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs-18_x
    pkgs.crystal_1_7
    pkgs.shards
    pkgs.dprint
    pkgs.nil
    pkgs.nixpkgs-fmt
  ];
}
