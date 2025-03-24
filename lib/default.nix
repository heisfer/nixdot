{ lib }:
let
  # from nixpkgs/lib
  callLibs = file: import file { inherit lib; };
in
{
  dotmod = {
    generators = callLibs ./generators.nix;
    types = callLibs ./types.nix;
    extra = callLibs ./extra.nix;
  };
}
