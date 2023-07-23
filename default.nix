{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/19a336ffabcd7d77cb3d55fa890ab64e7c4ac3f3.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs_20
    pkgs.dprint
    pkgs.nil
    pkgs.nixpkgs-fmt
    pkgs.typos

    # Section for crystal
    pkgs.crystal
    pkgs.shards
    # Used in crystal
    pkgs.pcre
    pkgs.crystalline
    pkgs.ameba
  ];
}
