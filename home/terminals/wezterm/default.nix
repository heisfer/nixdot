{
  pkgs,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = inputs.self.packages.${pkgs.system}.wezterm;
    extraConfig = builtins.readFile ./config.lua;
  };
}
