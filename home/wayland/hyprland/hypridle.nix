{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  # screen idle
  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.default;
    settings = {
      general = {
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
        lock_cmd = lib.getExe config.programs.hyprlock.package;
      };

      listener = [
        {
          timeout = 300; # 5min
          onTimeout = suspendScript.outPath;
        }
      ];
    };
  };
}
