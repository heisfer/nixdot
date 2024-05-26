{ pkgs, ... }:
let
  apps = with pkgs; [
    prismlauncher
    tutanota-desktop
    qdigidoc
    telegram-desktop
    (vesktop.override { withSystemVencord = false; })
    keepassxc
  ];

  dev = with pkgs; [
    devenv
    nixpkgs-review
    statix
    nh
    dbeaver-bin
    (pkgs.callPackage ../pkgs/beekeeper-studio { })
    (pkgs.callPackage ../pkgs/laravel { })
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
