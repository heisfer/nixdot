{
  lib,
  inputs,
  self',
  config,
  pkgs,
  ...
}:
let
  cfg = config.preconfigured.regreet;
in
{
  options = {
    preconfigured.regreet = {
      enable = lib.mkEnableOption "regreet";
    };
  };

  config = lib.mkIf cfg.enable {

    programs.regreet = {
      enable = true;
      theme.name = "RosePine-Main-B-LB";
      theme.package = self'.packages.rose-pine-gtk-theme;
      cursorTheme.name = "Bibata-Modern-Classic";
      cursorTheme.package = pkgs.bibata-cursors;
      font.size = 14;
      settings = {
        background = {
          path = "${inputs.wallpapers}/rose-pine.jpg";
          fit = "Cover";
        };
      };
    };
  };
}
