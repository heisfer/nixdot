{ pkgs, self', ... }:
{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    enable = true;
    font = {
      name = "IBM Plex Sans";
      package = pkgs.ibm-plex;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "RosePine-Main-B-LB";
      package = self'.packages.rose-pine-gtk-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  home.sessionVariables.GTK_THEME = "RosePine-Main-B-LB";
}
