{ pkgs }:
{
  webcord-vencord = pkgs.callPackage ./webcord-ven.nix {};
  miru = pkgs.callPackage ./miru.nix { };
}