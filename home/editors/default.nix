{ pkgs, ... }:
{
  imports = [
    ./helix
    ./neovim
  ];

  #lsp
  home.packages = with pkgs; [
    phpactor
    nodePackages_latest.intelephense
    nil
  ];
}