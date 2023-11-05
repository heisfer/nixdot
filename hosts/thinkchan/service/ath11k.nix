{...}: {
  # Custom service For thinkpad T14 Gen 3 wifi suspend
  # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14_(AMD)_Gen_3#Suspend/Hibernate
  systemd = {
    services = {
      ath11k-suspend = {
        description = "Suspend: rmmod ath11k-pci";
        before = ["sleep.target"];
        wantedBy = ["sleep.target"];
        serviceConfig = {
          ExecStart = "/run/current-system/sw/bin/rmmod ath11k_pci";
          Type = "simple";
        };
      };
      ath11k-resume = {
        description = "Resume: modprobe atk11k_pci";
        after = ["suspend.target"];
        wantedBy = ["suspend.target"];
        serviceConfig = {
          ExecStart = "/run/current-system/sw/bin/modprobe ath11k_pci";
          Type = "simple";
        };
      };
    };
  };
}
