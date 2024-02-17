{
  pkgs,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./config.lua;
  };
}
