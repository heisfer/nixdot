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
    theme = {
      name = "Rose-Pine-Dark";
      packages = [
        pkgs.local.rose-pine-gtk-theme
        pkgs.kanagawa-gtk-theme
      ];
    };
    iconTheme = {
      name = "Reversal-dark";
      packages = [
        pkgs.reversal-icon-theme
      ];
    };
    # gtk4.settings = {
    #   gtk-application-prefer-dark-theme = true;
    # };
    # gtk3.settings = {
    #   gtk-application-prefer-dark-theme = true;
    # };

  };

}
