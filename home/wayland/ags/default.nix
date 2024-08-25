{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dart-sass
    bun
  ];
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
