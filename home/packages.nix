{ pkgs, ... }:
let
  apps = with pkgs; [
    prismlauncher
    tutanota-desktop
    qdigidoc
    telegram-desktop
    vesktop
    keepassxc
  ];

  dev = with pkgs; [
    devenv
    statix
    nh
    dbeaver
    (pkgs.callPackage ../pkgs/beekeeper-studio { })
    (pkgs.callPackage ../pkgs/blade-formatter { })
    (pkgs.callPackage ../pkgs/tableplus { })
  ];
  utils = with pkgs; [
    wl-clipboard
    unzip
    zip
    xdg-utils
    nitch
  ];
in
{
  home.packages = apps ++ dev ++ utils;
}
