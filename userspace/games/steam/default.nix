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
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
