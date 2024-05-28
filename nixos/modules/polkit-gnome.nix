{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.services.polkit-gnome;
in
{
  options = {
    services.polkit-gnome = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Enable polkit gnome authentication agent
        '';
      };
    };
  };

  # Source: https://nixos.wiki/wiki/Polkit
  config = mkIf cfg.enable {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
