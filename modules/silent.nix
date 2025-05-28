{
  config,
  lib,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkDefault;
  cfg = config.boot.silent;
in
{
  options.boot.silent = {
    enable = mkEnableOption "silent boot";
  };

  config = mkIf cfg.enable {
    boot.initrd.verbose = false;
    boot.initrd.systemd.enable = true;
    boot.consoleLogLevel = 0;
    boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "udev.log_level=3"
    ];
    boot.loader.timeout = mkDefault 0;
    boot.loader.efi.canTouchEfiVariables = false;

  };

}
