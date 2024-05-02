{
  inputs,
  pkgs,
  ...
}: let
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
    inputs.heisfer-nixvim.packages.${pkgs.system}.default
    dbeaver
    (pkgs.callPackage ../pkgs/beekeeper-studio {})
    (pkgs.callPackage ../pkgs/tableplus {})
  ];
  utils = with pkgs; [
    unzip
    zip
    xdg-utils
    nitch
  ];
in {
  home.packages = apps ++ dev ++ utils;
}
