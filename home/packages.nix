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

  local = with pkgs; [
    (pkgs.callPackage ../pkgs/beekeeper-studio { })
    (pkgs.callPackage ../pkgs/laravel { })
    (pkgs.callPackage ../pkgs/blade-formatter { })
    (pkgs.callPackage ../pkgs/tableplus { })
  ];

  dev = with pkgs; [
    jetbrains.phpstorm
    devenv
    nixpkgs-review
    statix
    nh
    dbeaver-bin
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
  home.packages = apps ++ dev ++ utils ++ local;
}
