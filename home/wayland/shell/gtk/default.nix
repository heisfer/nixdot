{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Banana";
    package = pkgs.banana-cursor;
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.banana-cursor;
      name = "Banana";
    };

    theme = {
      # name = "rose-pine";
      # package = pkgs.rose-pine-gtk-theme;
      name = "Nightfox-Dark";
      package = pkgs.nightfox-gtk-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
