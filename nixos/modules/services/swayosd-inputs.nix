{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.swayosd-inputs;
in
{

  options = {
    services.swayosd-inputs = {
      enable = lib.mkEnableOption "swayosd inputs service";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.swayosd-libinput-backend = {
      description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc...";
      documentation = [ "https://github.com/ErikReider/SwayOSD" ];
      # partOf = [ "graphical.target" ];
      # after = [ "graphical.target" ];
      wantedBy = [ "graphical.target" ];

      unitConfig = {
        ConditionPathExists = lib.getExe' pkgs.swayosd "swayosd-libinput-backend";
        PartOf = [ "graphical.target" ];
      };

      serviceConfig = {
        Type = "dbus";
        BusName = "org.erikreider.swayosd";
        ExecStart = lib.getExe' pkgs.swayosd "swayosd-libinput-backend";
        Restart = "on-failure";
      };

    };
  };

}
