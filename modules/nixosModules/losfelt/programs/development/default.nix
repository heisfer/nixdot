{
  flake.nixosModules.losfelt =
    { config, lib, ... }:
    let
      inherit (lib) mkEnableOption;
    in
    {
      options.losfelt.programs.development.enable = mkEnableOption "Electronics development suit";

    };
}
