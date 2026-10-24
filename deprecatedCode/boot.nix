{
  flake.nixosModules.base = {
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];
      loader.limine = {
        enable = true;
        efiInstallAsRemovable = true;
        efiSupport = true;
        style = {
          graphicalTerminal = {
            palette = "191724;eb6f92;9ccfd8;f6c177;31748f;c4a7e7;9ccfd8;e0def4";
            brightPalette = "6e6a86;eb6f92;9ccfd8;f6c177;31748f;c4a7e7;9ccfd8;e0def4";
            background = "191724";
            foreground = "e0def4";
            brightBackground = "6e6a86";
            brightForeground = "e0def4";
          };
          wallpapers = [ ];
        };
      };
    };

    boot.zfs.forceImportRoot = true;
    boot.loader.efi.canTouchEfiVariables = true;

  };
}
