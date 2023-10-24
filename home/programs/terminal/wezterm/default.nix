{pkgs,  ... }:
let
localPkgs = import ../../../../pkgs/default.nix { pkgs = pkgs; };
  
in
{
    programs.wezterm  = {
        enable = true;
        package = localPkgs.wezterm;
        extraConfig = builtins.readFile ./wezterm.lua;
    };
}
