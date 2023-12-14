{pkgs, ...}: {
      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
        configPackages = [ pkgs.xdg-desktop-portal-hyprland ]; # needed from 23.11
      };

}
