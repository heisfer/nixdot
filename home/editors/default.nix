{ pkgs, ... }:
{
  imports = [
    ./helix
    ./neovim
    ./vscode
  ];

  #lsp
  home.packages = with pkgs; [
    phpactor
    nodePackages_latest.intelephense
    nil
  ];
}
