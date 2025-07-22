{ pkgs, ... }:
{
  programs.adb.enable = true;

  users.users.heisfer.extraGroups = [ "adbusers" ];
  environment.systemPackages = [ pkgs.scrcpy ];

}
