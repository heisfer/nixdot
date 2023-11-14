{ pkgs, ... }:
{
  imports = [
    ./helix
    ./neovim
    ./vscode
  ];

  #lsp
  home.packages = with pkgs; [
    luajitPackages.lua-lsp
    rnix-lsp
    phpactor
    nodePackages_latest.intelephense
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-css-languageserver-bin
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.vscode-json-languageserver
    nodePackages_latest.bash-language-server
    lua-language-server
    yaml-language-server
    nil
  ];
}
