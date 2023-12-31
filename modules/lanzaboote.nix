{
  pkgs,
  lib,
  ...
}: {
  boot = {
    bootspec.enable = true;
    plymouth.enable = true;
    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = lib.mkForce false;
      timeout = 0;
    };
  };

  environment.systemPackages = [pkgs.sbctl];
}
