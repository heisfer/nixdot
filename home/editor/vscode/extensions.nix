{ pkgs, inputs, ... }:
let
  marketplace-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
  ui = with marketplace-extensions; [
    gregoire.dance
    mvllow.rose-pine
    sulsami.rose-pine-burnt
  ];
  misc = with marketplace-extensions; [
    mkhl.direnv
    bmewburn.vscode-intelephense-client
  ];
in
{
  programs.vscode.extensions = ui ++ misc;
}
