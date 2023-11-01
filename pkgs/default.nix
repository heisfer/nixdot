{ pkgs }:
{
  webcord-vencord = pkgs.callPackage ./webcord-ven.nix {};
  miru = pkgs.callPackage ./miru.nix { };
  wezterm = pkgs.callPackage ./wezterm.nix { };
  station = pkgs.callPackage ./station.nix { };
}
