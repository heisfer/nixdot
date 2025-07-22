{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
    extraPackages = with pkgs; [
      gamescope
      nss
    ];
    protontricks = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    wineWow64Packages.waylandFull
  ];
}
