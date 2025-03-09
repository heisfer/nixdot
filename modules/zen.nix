{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib) types;
  inherit (lib.types) str;

  cfg = config.programs.zen;

  jsonFormat = pkgs.formats.json { };

  profiles =
    lib.flip lib.mapAttrs' cfg.profiles (
      _: profile:
      lib.nameValuePair "Profile${builtins.toString profile.id}" {
        Name = profile.name;
        IsRelative = 1;
        Path = profile.name;
        Default = if profile.isDefault then 1 else 0;
      }
    )
    // {
      General = {
        StartWithLastProfile = 1;
        Version = 2; # i wonder if it's required
      };
    };

  profilesIni = lib.generators.toINI { } profiles;
in
{
  options.programs.zen = {
    enable = mkEnableOption "zen browser";
    package = mkOption {
      type = types.package;
    };

    users = mkOption {
      type = types.listOf str;
      default = config.shitfest.users;
      description = "List of hjem users";
      example = [ "username" ];
    };

    profiles = mkOption {
      default = { };
      description = "Zen Profiles";
      type = types.attrsOf (
        types.submodule (
          { config, name, ... }:
          {
            options = {
              name = mkOption {
                type = types.str;
                default = name;
                description = "Profile name";
              };
              id = mkOption {
                type = types.ints.unsigned;
                default = 0;
                description = "Profile ID";
              };
              isDefault = mkOption {
                type = types.bool;
                default = config.id == 0;
              };

            };
          }
        )
      );
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    hjem.users = mkMerge (
      lib.lists.forEach cfg.users (user: {
        ${user}.files = {
          ".zen/profiles.ini" = mkIf (cfg.profiles != { }) {
            text = profilesIni;
          };
        };
      })
    );

  };

}
