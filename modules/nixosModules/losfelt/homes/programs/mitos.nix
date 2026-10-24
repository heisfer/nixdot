{
  flake.nixosModules.losfelt =  {
    hjem.extraModules = [
      (
        { lib, pkgs, config, inputs, ... }:
        let
          inherit (lib) mkEnableOption mkOption mkIf concatLines;
          inherit (lib.types) package listOf str;
          cfg = config.programs.mitos;
          toml = pkgs.formats.toml { };
        in
        {
          options.programs.mitos = {
            enable = mkEnableOption "Mitos";
            package = mkOption {
              type = package;
              default = inputs.mitos.packages."${pkgs.stdenv.hostPlatform.system}".default;
            };
            settings = mkOption {
              type = toml.type;
              default = { };
            };
            ignore = mkOption {
              type = listOf str;
              default = [ ];
            };
          };

          config = mkIf cfg.enable {
            packages = [ cfg.package ];
            files.".config/mitos/config.toml".source = toml.generate "mitos-config.toml" cfg.settings;
            files.".config/mitos/ignore".text = concatLines cfg.ignore;
          };
        }
      )
    ];
  };
}
