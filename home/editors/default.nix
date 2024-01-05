{pkgs, ...}: {
  home.packages = with pkgs; [
    golangci-lint-langserver
    lua-language-server
    golangci-lint
  ];
  imports = [
    ./helix
    ./code
  ];
}
