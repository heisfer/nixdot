
{ config, pkgs, lib, ... }: {
  # Starship Prompt
  # https://nix-community.github.io/home-manager/options.html#opt-programs.starship
  programs.starship = {

    # Starship - Enable
    # https://nix-community.github.io/home-manager/options.html#opt-programs.starship.enable
    enable = true;

    # Starship - Bash Integration
    # https://nix-community.github.io/home-manager/options.html#opt-programs.starship.enableBashIntegration
    enableBashIntegration = true;

  };
}
