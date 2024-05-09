{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.services.ath11k-sleep;
in
{
  options = {
    services.ath11k-sleep = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Enable suspend/resume on ath11k bug
        '';
      };
    };
  };

  # Source: https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14_(AMD)_Gen_3#Suspend/Hibernate
  config = mkIf cfg.enable {
    systemd.services.ath11k-suspend = {
      wantedBy = [ "sleep.target" ];
      before = [ "sleep.target" ];
      description = "Suspend: modprobe ath11k_pci";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kmod}/bin/modprobe -a -r ath11k_pci ath11k'';
      };
    };
    systemd.services.ath11k-resume = {
      wantedBy = [ "suspend.target" ];
      after = [ "suspend.target" ];
      description = "Resume: modprobe ath11k_pci";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kmod}/bin/modprobe -a ath11k_pci ath11k'';
      };
    };
  };
}
