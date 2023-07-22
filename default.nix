{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/e57b65abbbf7a2d5786acc86fdf56cde060ed026.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs-18_x
    pkgs.crystal_1_8
    pkgs.shards
    pkgs.dprint
    pkgs.nil
    pkgs.nixpkgs-fmt
    pkgs.pcre
    pkgs.typos
  ];
}
