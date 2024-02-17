{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    golangci-lint-langserver
    lua-language-server
    golangci-lint
    inputs.heisfer-nixvim.packages.${pkgs.system}.default
  ];
  imports = [
    ./helix
    ./code
  ];
}
