{pkgs, ...}: {
  programs.rofi = {
    enable = true;
#    font = "Comic Code Ligatures 14";
    package = pkgs.rofi-wayland;
    theme = ./ayu.rasi;
  };
#  xdg.configFile."rofi".source = ./config;
}
