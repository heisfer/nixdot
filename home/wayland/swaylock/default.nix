{pkgs, ...}: let
  localPkgs = import ../../../pkgs/default.nix {pkgs = pkgs;};
in {
  programs.swaylock = {
    enable = true;
    package = localPkgs.swaylock-fprintd;
  };
}
