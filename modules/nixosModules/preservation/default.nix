{ inputs, ... }: {
  flake.nixosModules.preserve = {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    preservation = {
      enable = true;
      preserveAt."/persist" = {
        directories = [
          "/etc/nixos"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/userborn"
          {
            directory = "/var/lib/fprint";
            mode = "0700";
          }
          "/var/lib/hjem"
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];
        users.heisfer = {
          directories = [
            ".config/mozilla"
            ".config/YouTube Music"
            #to be removed :)
            ".config/hypr"
            "Projects"
          ];
        };
      };
    };
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

    systemd.tmpfiles.rules = [
      "d /home 0755 root root -"
      "d /home/heisfer 0700 heisfer users -"
      "Z /home/heisfer 0700 heisfer users -"

      # Explicitly pre-create the ZFS target path so ZFS doesn't trip
      "d /home/heisfer/.local 0700 heisfer users -"
      "d /home/heisfer/.local/share 0700 heisfer users -"
      "d /home/heisfer/.local/share/Steam 0700 heisfer users -"
      "d /home/heisfer/.local/share/Steam/steamapps 0700 heisfer users -"
      "d /home/heisfer/.local/share/Steam/steamapps/compatdata 0700 heisfer users -"
    ];

    # let the service commit the transient ID to the persistent volume
    systemd.services.systemd-machine-id-commit = {
      unitConfig.ConditionPathIsMountPoint = [
        ""
        "/persist/etc/machine-id"
      ];
      serviceConfig.ExecStart = [
        ""
        "systemd-machine-id-setup --commit --root /persist"
      ];
    };
  };

}
