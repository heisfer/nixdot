{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.options) mkEnableOption mkOption mkPackageOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) listOf str;

  cfg = config.programs.helix;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.helix = {
    enable = mkEnableOption "helix";

    package = mkPackageOption pkgs "helix" { };
    users = mkOption {
      type = listOf str;
      default = [ ];
    };
    settings = mkOption {
      type = tomlFormat.type;
      default = { };
    };
    languages = mkOption {
      type = tomlFormat.type;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    # Lets hope this works :)
    hjem.users = builtins.listToAttrs (
      builtins.map (name: {
        inherit name;
        value = {
          files.".config/helix/config.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "helix-config" cfg.settings;
          };
          files.".config/helix/languages.toml" = mkIf (cfg.languages != { }) {
            source = tomlFormat.generate "helix-languages-config" cfg.languages;
          };
        };
      }) cfg.users
    );

  };
}
