{
  config,
  lib,
  pkgs,
  ...
}:
{
  # customize kernel version
  # boot.kernelPackages = pkgs.linuxPackages_5_15;

  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.initrd.systemd = {
    enable = true;
    services.initrd-rollback-root = {
      after = [ "zfs-import-vault.service" ];
      wantedBy = [ "initrd.target" ];
      before = [ "sysroot.mount" ];
      path = [ pkgs.zfs ];
      description = "Rollback root fs";
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = "zfs rollback -r vault/nixos/root@empty";
    };
  };

  users.users = {
    heisfer = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "test";
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.hostId = "4e98920d";

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  environment.systemPackages = with pkgs; [
    htop
    dysk
    tree
  ];

  system.stateVersion = "25.11";
}
