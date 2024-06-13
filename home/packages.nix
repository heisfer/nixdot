{ pkgs, self', ... }:
let
  apps = with pkgs; [
    prismlauncher
    tutanota-desktop
    teamviewer
    rustdesk
    qdigidoc
    onlyoffice-bin_latest
    telegram-desktop
    (vesktop.override { withSystemVencord = false; })
    keepassxc
    termusic
  ];

  local = with self'.packages; [
    beekeeper-studio
    tableplus
    zoho-mail-desktop
  ];

  dev = with pkgs; [
    laravel
    devbox
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
