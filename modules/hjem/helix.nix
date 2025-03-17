{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.options) mkEnableOption mkOption mkPackageOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.types) listOf str package;
  inherit (lib.strings)
    getName
    getVersion
    makeBinPath
    concatStringsSep
    ;

  cfg = config.programs.helix;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.helix = {
    enable = mkEnableOption "helix";

    package = mkPackageOption pkgs "helix" { };

    extraPackages = mkOption {
      type = listOf package;
      default = [ ];
      description = "Extra packages for helix";
      example = [
        pkgs.nixd
        pkgs.nil
      ];
    };

    users = mkOption {
      type = listOf str;
      default = config.shitfest.users; # I have no idea how to automate this
      description = "List of users under hjem.users.<users>";
      example = [ "username" ];
    };

    ignore = mkOption {
      type = listOf str;
      default = [ ];
      description = "List of paths to be globaly ignored";
      example = [
        "flake.lock"
        ".gitignore"
      ];
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

    environment.systemPackages =
      if cfg.extraPackages == [ ] then
        [ cfg.package ]
      else
        [
          (pkgs.symlinkJoin {
            name = "${getName cfg.package}-wrapped-${getVersion cfg.package}";
            paths = [ cfg.package ];
            preferLocalBuild = true;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/hx \
                --suffix PATH = ${makeBinPath cfg.extraPackages}
            '';
          })
        ];
    hjem.users = mkMerge (
      lib.lists.forEach cfg.users (user: {
        ${user}.files = {
          ".config/helix/config.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "helix-config" cfg.settings;
          };
          ".config/helix/languages.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "helix-languages-config" cfg.languages;
          };
          ".config/helix/ignore" = mkIf (cfg.settings != { }) {
            text = concatStringsSep "\n" cfg.ignore + "\n";
          };
        };
      })
    );
  };

}
