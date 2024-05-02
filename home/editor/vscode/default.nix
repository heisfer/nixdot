{
  imports = [
    ./extensions.nix
  ];
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Rosé Pine";
      "workbench.iconTheme" = "rose-pine-icons";
    };
  };
}
