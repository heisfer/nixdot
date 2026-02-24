{ inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.default ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/NetworkManager/system-connections"
      "/voks"
    ];
    files = [
      "/etc/machine-id"
      "/me"
    ];

    users.heisfer = {
      directories = [
        "Music"
        "Projects"
        "Games"

      ];
    };
  };

}
