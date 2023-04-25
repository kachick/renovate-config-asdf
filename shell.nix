{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f3f15fa73ddf15fa66cc4f80cda4c5afb356306b.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs-18_x
    pkgs.crystal_1_8
    pkgs.shards
    pkgs.dprint
    pkgs.nil
    pkgs.nixpkgs-fmt
  ];
}
