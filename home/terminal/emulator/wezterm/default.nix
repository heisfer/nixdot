{ pkgs, inputs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm-nightly.packages.${pkgs.system}.default;
    extraConfig = builtins.readFile ./config.lua;
  };
}
