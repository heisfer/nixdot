{ pkgs, self', ... }:
let
  apps = with pkgs; [
    prismlauncher
    tutanota-desktop
    teamviewer
    rustdesk
    qdigidoc
    telegram-desktop
    (vesktop.override { withSystemVencord = false; })
    keepassxc
  ];

  local = with self'.packages; [
    beekeeper-studio
    blade-formatter
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
