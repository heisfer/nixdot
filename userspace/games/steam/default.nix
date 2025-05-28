{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
    extraPackages = with pkgs; [
      gamescope
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
}
