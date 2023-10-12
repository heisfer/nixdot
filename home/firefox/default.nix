{
  pkgs,
  lib,
  inputs,
  extraArgs,
  ...
}:
let

  inherit (extraArgs) addons;

  extensions = with addons; [
    ublock-origin
    bitwarden
  ];

in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    profiles = {
      dev-edition-default = {
        id = 0;
        inherit  extensions;
      };
    };
  };
  home = {
      sessionVariables.BROWSER = "firefox";
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox-developer-edition.desktop" ];
      "text/xml" = [ "firefox-developer-edition.desktop" ];
      "x-scheme-handler/http" = [ "firefox-developer-edition.desktop" ];
      "x-scheme-handler/https" = [ "firefox-developer-edition.desktop" ];
    };

}
