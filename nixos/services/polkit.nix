{ pkgs, ... }:
{
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    unitConfig = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
    wantedBy = [ "graphical-session.target" ];
  };
}
