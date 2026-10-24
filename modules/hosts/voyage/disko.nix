{ inputs, ... }: {
  flake.nixosModules.voyage = { pkgs, ... }: {
    imports = [
      inputs.disko.nixosModules.disko
    ];
    boot.zfs.extraPools = [ "vault" ];

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    disko.devices.disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";

      content.type = "gpt";

      content.partitions.boot = {
        name = "boot";
        size = "1M";
        type = "EF02";
      };

      content.partitions.esp = {
        name = "ESP";
        size = "4G";
        type = "EF00";

        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };

      content.partitions.swap = {
        size = "32G";

        content = {
          type = "swap";
          resumeDevice = true;
        };
      };

      content.partitions.zfs = {
        size = "100%";
        content = {
          type = "zfs";
          pool = "vault";
        };
      };

    };

    disko.devices.zpool.vault = {
      type = "zpool";
      rootFsOptions = {
        mountpoint = "none";
        compression = "zstd";
        acltype = "posixacl";
        xattr = "sa";
      };
      options.ashift = "12";
      datasets = {
        "nixos" = {
          type = "zfs_fs";
          options = {
            encryption = "on";
            keyformat = "passphrase";
            keylocation = "prompt";
            mountpoint = "none";
          };
        };
        "nixos/root" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/";
          postCreateHook = "zfs snapshot vault/nixos/root@empty";
        };
        "nixos/nix" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/nix";
        };
        "nixos/persist" = {
          type = "zfs_fs";
          options.mountpoint = "legacy";
          mountpoint = "/persist";
        };
        "nixos/steam/compatdata" = {
          type = "zfs_fs";
          options = {
            recordsize = "64K";
            casesensitivity = "insensitive";
            mountpoint = "legacy";
          };
          mountpoint = "/home/heisfer/.local/share/Steam/steamapps/compatdata";
        };

      };
    };
    boot.initrd.systemd = {
      enable = true;
      services.initrd-rollback-root = {
        after = [ "zfs-import-vault.service" ];
        wantedBy = [ "initrd.target" ];
        before = [ "sysroot.mount" ];
        path = [ pkgs.zfs ];
        description = "Rollback root fs -DDDDD";
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = "zfs rollback -r vault/nixos/root@empty";
      };
    };

  };
}
