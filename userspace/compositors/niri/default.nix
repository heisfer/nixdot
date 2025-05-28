{
  programs.niri = {
    enable = true;
  };
  programs.uwsm.waylandCompositors.niri = {
    prettyName = "Niri";
    comment = "Niri";
    binPath = "/run/current-system/sw/bin/niri-session";
  };

  xdg.portal.config.niri = {
    default = "gtk;gnome";
  };

}
