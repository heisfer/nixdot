{ pkgs, self', ... }:
let
  apps = with pkgs; [
    prismlauncher
    tutanota-desktop
    qdigidoc
    telegram-desktop
    (vesktop.override { withSystemVencord = false; })
    keepassxc
  ];

  local = with self'.packages; [
    laravel
    beekeeper-studio
    blade-formatter
    tableplus
    clickup
    zoho-mail-desktop-lite
  ];

  dev = with pkgs; [
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
