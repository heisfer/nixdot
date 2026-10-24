{
  flake.nixosModules.losfelt =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      inherit (lib)
        mkEnableOption
        mkIf
        ;

      cfg = config.losfelt.essentials.git;
    in
    {
      options.losfelt.essentials.git = {
        enable = mkEnableOption "" // {
          default = true;
        };
      };

      config = mkIf cfg.enable {
        programs.git.enable = true;
      };
    };
}
