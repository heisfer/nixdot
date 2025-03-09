{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.options) mkEnableOption mkOption mkPackageOption;
  inherit (lib.modules) mkIf mkMerge;
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
      default = config.shitfest.users; # I have no idea how to automate this
      description = "List of users under hjem.users.<users>";
      example = [ "username" ];
    };

    settings = mkOption {
      type = tomlFormat.type;
      default = { };
      description = "Helix configuration. List of options https://docs.helix-editor.com/configuration.html";
      example = {
        theme = "rose_pine";
        editor = {
          line-number = "relative";
          file-picker = {
            hidden = false;
          };
        };
      };
    };
    languages = mkOption {
      type = tomlFormat.type;
      default = { };
      description = "Helix Languages configuration. List of options in https://docs.helix-editor.com/languages.html";
      example = {
        language-server = {
          nixd = {
            command = "nixd";
            config.nixd = {
              formatting.command = [ "nixfmt-rfc-style" ];
            };
          };
        };
        language = [
          {
            name = "nix";
            language-servers = [ "nixd" ];
            auto-format = true;
          }
        ];
      };
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [ cfg.package ];
    hjem.users = mkMerge (
      lib.lists.forEach cfg.users (user: {
        ${user}.files = {
          ".config/helix/config.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "helix-config" cfg.settings;
          };
          ".config/helix/languages.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "helix-languages-config" cfg.languages;
          };
        };
      })
    );
  };

}
