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

  cfg = config.programs.nushell;
in
{
  options.programs.nushell = {
    enable = mkEnableOption "helix";

    package = mkPackageOption pkgs "nushell" { };

    users = mkOption {
      type = listOf str;
      default = config.userspace.hjemUsers; # I have no idea how to automate this
      description = "List of users under hjem.users.<users>";
      example = [ "username" ];
    };

  };

  config = mkIf cfg.enable {

    environment.systemPackages = [ cfg.package ];
    # hjem.users = mkMerge (
    #   lib.lists.forEach cfg.users (user: {
    #     ${user}.files = {
    #       ".config/helix/config.toml" = mkIf (cfg.settings != { }) {
    #         source = tomlFormat.generate "helix-config" cfg.settings;
    #       };
    #       ".config/helix/languages.toml" = mkIf (cfg.settings != { }) {
    #         source = tomlFormat.generate "helix-languages-config" cfg.languages;
    #       };
    #       ".config/helix/ignore" = mkIf (cfg.settings != { }) {
    #         text = concatStringsSep "\n" cfg.ignore + "\n";
    #       };
    #     };
    #   })
    # );
  };

}
