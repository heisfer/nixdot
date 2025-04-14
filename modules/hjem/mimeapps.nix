{
  config,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib) toList;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf;

  inherit (lib.types)
    coercedTo
    either
    listOf
    str
    attrsOf
    ;

  inherit (lib.attrsets) genAttrs mapAttrs;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.generators) toINI;

  cfg = config.xdg.mimeApps;

  strListOrSingleton = coercedTo (either (listOf str) str) toList (listOf str);

  joinValues = mapAttrs (n: concatStringsSep ";");
in
{
  options.xdg.mimeApps = {
    enable = mkEnableOption "helix";

    users = mkOption {
      type = listOf str;
      default = config.userspace.hjemUsers; # I have no idea how to automate this
      description = "List of users under hjem.users.<users>";
      example = [ "username" ];
    };

    defaultApplication = mkOption {
      type = attrsOf strListOrSingleton;
      default = { };
      example = {
        "application/zip" = [ "ark.desktop" ];
      };
    };

  };

  config = mkIf cfg.enable {

    hjem.users = genAttrs cfg.users (user: {
      files.".config/mimeapps.list".text = toINI { } {
        "Added Associations" = joinValues cfg.defaultApplication;
      };

    });
  };

}
