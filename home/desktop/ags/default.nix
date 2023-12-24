{
  inputs,
  pkgs,
  ...
}: {
  # add the home manager module

  home.packages = with pkgs; [
    sassc
    python311Packages.python-pam
  ];
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./config;

    extraPackages = with pkgs; [
      libgtop
      libsoup_3
    ];
  };
}
