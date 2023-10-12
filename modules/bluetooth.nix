{lib, pkgs, ...}: {
  hardware = {
    bluetooth = {
      enable = lib.mkDefault true;
      package = pkgs.bluez;
      powerOnBoot = lib.mkDefault true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}