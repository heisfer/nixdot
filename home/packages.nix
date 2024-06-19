{ pkgs, self', ... }:
let
  apps = with pkgs; [
    tutanota-desktop
    teamviewer
    rustdesk
    qdigidoc
    onlyoffice-bin_latest
    telegram-desktop
    (vesktop.override { withSystemVencord = false; })
    keepassxc
    termusic
    vlc
    mpv
  ];

  games = with pkgs; [
    prismlauncher
    tetrio-desktop
  ];

  local = with self'.packages; [
    beekeeper-studio
    tableplus
    zoho-mail-desktop
    spacedrive
  ];

  dev = with pkgs; [
    laravel
    devbox
    jetbrains.phpstorm
    devenv
    jetbrains.idea-community-bin
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
  home.packages = apps ++ dev ++ utils ++ local ++ games;
}
