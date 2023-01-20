{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/bbbcb362e8a623c8125bdccb72d2d6a874548862.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs-18_x
    pkgs.crystal_1_7
    pkgs.dprint
    pkgs.nil
    pkgs.nixpkgs-fmt
  ];
}
