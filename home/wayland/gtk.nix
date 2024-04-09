{
  self,
  pkgs,
  ...
}: {
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
      package = pkgs.callPackage ../../pkgs/rose-pine-gtk/defalut.nix {};
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  home.sessionVariables.GTK_THEME = "Juno";
}
