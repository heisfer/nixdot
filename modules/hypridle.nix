{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.dotmod.types) hyprlang;
  inherit (lib.dotmod.generators) toHyprlang;
  cfg = config.services.hypridle;
in
{
  options.services.hypridle = {
    settings = mkOption {
      type = hyprlang;
      description = "Hypridle configuration value";
      default = { };
    };
  };
  config = mkIf cfg.enable {
    environment.etc."xdg/hypr/hypridle.conf" = mkIf (cfg.settings != { }) {
      text = toHyprlang { inherit (cfg) settings; };
    };
  };
}
