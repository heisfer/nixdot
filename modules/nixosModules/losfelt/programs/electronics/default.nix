{
  flake.nixosModules.losfelt =
    { config, lib, ... }:
    let
      inherit (lib) mkEnableOption;
    in
    {
      options.losfelt.programs.electronics.enable = mkEnableOption "Electronics software suit";

    };
}
