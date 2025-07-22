{ config, ... }:
{
  programs.niri = {
    enable = true;
  };
  programs.uwsm.waylandCompositors.niri = {
    prettyName = "Niri";
    comment = "Niri";
    binPath = "${config.programs.niri.package}/bin/niri-session";
  };

  xdg.portal.config.niri = {
    default = "gtk;gnome";
  };

}
