{
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.dotmod.types) hyprlang;
  inherit (lib.dotmod.generators) toHyprlang;

  cfg = config.programs.hyprlock;
in
{
  options.programs.hyprlock = {
    settings = mkOption {
      type = hyprlang;
      description = "Hyprlock configuration value";
      default = { };
    };
  };

  config = mkIf cfg.enable {
    environment.etc."xdg/hypr/hyprlock.conf" = mkIf (cfg.settings != { }) {
      text = toHyprlang { inherit (cfg) settings; };
    };
  };

}
