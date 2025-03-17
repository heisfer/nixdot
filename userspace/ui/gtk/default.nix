{ pkgs, ... }:
{
  ui.gtk = {
    enable = true;
    enableDark = true;
    cursorTheme = {
      name = "Banana";
      size = 32;
      packages = [ pkgs.banana-cursor ];
    };
    theme.packages = [
      pkgs.local.rose-pine-gtk-theme
      pkgs.kanagawa-gtk-theme
    ];
    theme.name = "Rose-Pine-Dark";
    gtk4.settings = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk3.settings = {
      gtk-application-prefer-dark-theme = true;
    };

  };

}
