{ lib, ... }:

let
  inherit (lib) mapAttrs' nameValuePair;

  files = builtins.readDir ./modules;

  # Recursively process subdirectories
  collect =
    path:
    let
      entries = builtins.readDir path;
    in
    mapAttrs' (
      name: type:
      let
        fullPath = "${path}/${name}";
      in
      if type == "directory" then
        nameValuePair name (collect fullPath)
      else if lib.hasSuffix ".nix" name then
        nameValuePair (lib.removeSuffix ".nix" name) (/. + fullPath)
      else
        null
    ) entries
    // { }
    // lib.filterAttrs (_: v: v != null);
in

collect ./modules // { } # Start at current dir if `default.nix` is in ./modules/
