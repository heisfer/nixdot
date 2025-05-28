{ inputs, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rofi-wayland ];

  hjem.users.heisfer.files.".config/rofi/config.rasi" = {
    source = inputs.rofi-rose-pine + "/rose-pine.rasi";
  };
}
