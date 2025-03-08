pkgs:
let
  lib = pkgs.lib;
  dirs = lib.filterAttrs (_: n: n == "directory") (builtins.readDir ./.);
  packages = lib.mapAttrs (name: _: pkgs.callPackage ./${name}/package.nix { }) dirs;

in
packages
