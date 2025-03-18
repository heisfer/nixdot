{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkDefault;
  cfg = config.programs.firefox;
in
{
  options.programs.firefox = {
    euwebid = mkEnableOption "euwebid integrations";
  };

  config = mkIf cfg.euwebid {
    services.pcscd.enable = mkDefault true;
    environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
      module: ${pkgs.opensc}/lib/opensc-pkcs11.so
    '';
    programs.firefox.nativeMessagingHosts.packages = [ pkgs.web-eid-app ];
    programs.firefox.policies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";

  };
}
