{
  boot.initrd.systemd.enable = true;
  system.etc.overlay.enable = true;
  services.userborn.enable = true;

  system.tools.nixos-generate-config.enable = false;
  programs.less.lessopen = null;
  boot.loader.grub.enable = false;
  environment.defaultPackages = [ ];
  programs.command-not-found.enable = false;
  documentation.nixos.enable = false;
  documentation.info.enable = false;

  system.forbiddenDependenciesRegexes = [ "perl" ];

}
