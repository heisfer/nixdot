{ inputs, pkgs, ... }:
{
  programs.zen = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.system}.default;
    profiles.default = {
      name = "default";
    };
  };
}
