{
  pkgs,
  self',
  inputs,
  ...
}:
let
  apps = with pkgs; [
    tutanota-desktop
    teamviewer
    # rustdesk
    qdigidoc
    onlyoffice-bin_latest
    telegram-desktop
    keepassxc
    # termusic
    vlc
    mpv
    (flameshot.overrideAttrs (oldAttrs: {
      version = oldAttrs.version + "-unstable-latest";
      src = pkgs.fetchFromGitHub {
        owner = "flameshot-org";
        repo = "flameshot";
        rev = "c1dac52231024174faa68a29577129ebca125dff";
        hash = "sha256-Y9RnVxic5mlRIc48wYVQXrvu/s65smtMMVj8HBskHzE=";
      };
    }))
  ];

  games = with pkgs; [
    prismlauncher
    tetrio-desktop
  ];

  local = with self'.packages; [
    beekeeper-studio
    zoho-mail-desktop
    spacedrive
  ];

  dev = with pkgs; [
    laravel
    jetbrains.phpstorm
    devenv
    jetbrains.idea-community-bin
    nixpkgs-review
    statix
    nh
    dbeaver-bin
    devdocs-desktop
  ];
  utils = with pkgs; [
    wl-clipboard
    unzip
    unrar
    p7zip
    zip
    xdg-utils
    nitch
  ];
  inputs-package = [
    inputs.ashell.defaultPackage."${pkgs.system}"
    inputs.zen-browser.packages."${pkgs.system}".specific
  ];
in
{
  home.packages = apps ++ dev ++ utils ++ local ++ games ++ inputs-package;
}
