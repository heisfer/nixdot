{
  config,
  lib,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) unspecified;
  inherit (lib.modules) mkIf mkMerge;

  cfg.wezterm = config.programs.wezterm;
  cfg.ghostty = config.programs.ghostty;
  cfg.foot = config.programs.foot;
in
{
  # options.programs.firefox.default = mkEnableOption "dsa";

  options.programs.wezterm.default = mkEnableOption "Set it as default terminal";
  options.programs.ghostty.default = mkEnableOption "Set it as default terminal";
  options.programs.foot.default = mkEnableOption "Set it as default terminal";

  options.default.terminal = mkOption {
    type = unspecified;
    default = { };
    description = "Default terminal data";
  };

  config.default.terminal = mkMerge [
    (mkIf cfg.wezterm.default cfg.wezterm)
    (mkIf cfg.ghostty.default cfg.ghostty)
    (mkIf cfg.foot.default cfg.foot)
  ];

  # config.assertions = [
  #   {
  #     assertion = ();
  #   }
  # ];

}
