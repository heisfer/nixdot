{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    wl-clipboard
  ];
}
