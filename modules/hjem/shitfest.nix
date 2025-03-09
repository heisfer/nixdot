{
  config,
  lib,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) listOf str;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) forEach;

  cfg = config.shitfest;
in
{
  options.shitfest = {
    enable = mkEnableOption "shitfest";
    users = mkOption {
      type = listOf str;
      default = [ ];
      description = "List of users for hjem";
    };
    clobberByDefault = mkEnableOption "hjem clobber";
  };
  config = mkIf cfg.enable {
    hjem.users = mkMerge (
      forEach cfg.users (user: {
        ${user} = {
          enable = true;
        };
      })
    );
    hjem.clobberByDefault = cfg.clobberByDefault;
  };

}
