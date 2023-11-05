{
  config
, pkgs
, ...
}:

{
  networking.hostName = "thinkchan";
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
  networking.networkmanager.enable = true;
}
