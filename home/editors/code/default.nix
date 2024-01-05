{
  pkgs,
  inputs,
  ...
}: let
in {
  imports = [
    ./extensions.nix
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    userSettings = {
      #UI
      "editor.fontFamily" = "Comic Code Ligatures ";
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "bold";
      "editor.fontSize" = 16;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Rosé Pine";
      "workbench.iconTheme" = "rose-pine-icons";
    };
  };
}
