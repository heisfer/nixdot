{
  flake.nixosModules.graphics = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      noto-fonts
      ibm-plex
      nerd-fonts.jetbrains-mono
    ];

    programs.hyprland = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      hyprlauncher

    ];
  };
}
