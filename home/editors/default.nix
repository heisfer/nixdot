{pkgs, ...}: {
  imports = [
    ./helix
    ./neovim
    ./vscode
  ];

  #lsp
  home.packages = with pkgs; [
    luajitPackages.lua-lsp
    lua-language-server
    nil
    nixd
    nixpkgs-fmt
    nodePackages_latest.bash-language-server
    nodePackages_latest.intelephense
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-css-languageserver-bin
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.vscode-json-languageserver
    nodePackages_latest.vscode-json-languageserver
    phpactor
    rnix-lsp
    vala-language-server
    yaml-language-server
  ];
}
