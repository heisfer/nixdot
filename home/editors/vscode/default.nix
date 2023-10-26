{
  pkgs
,  ...
}: {
 
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
  };
}
