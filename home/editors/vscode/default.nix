{
  pkgs
, extraArgs
,  ...
}: {
 
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    extensions = with extraArgs.vscode-extensions.vscode-marketplace; [
      teabyii.ayu
      nullxception.cherry-theme
      gulajavaministudio.mayukaithemevsc
      #php
      devsense.phptools-vscode
      bmewburn.vscode-intelephense-client
      #nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      mkhl.direnv
      
      #dart
      dart-code.flutter
      dart-code.dart-code
      #AI?
      codeium.codeium
    ];
    userSettings = {
      #UI
      "workbench.colorTheme" = "Cherry Midnight";
      "window.titleBarStyle" = "custom";
      "editor.fontFamily" = "Comic Code Ligatures";
      
    };
  };
}
