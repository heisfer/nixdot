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

  extraConfig = ''
  user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
  user_pref("browser.search.widget.inNavBar", false);
  user_pref("services.sync.prefs.sync.browser.urlbar.showSearchSuggestionsFirst", false);
  '';

in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    profiles = {
      dev-edition-default = {
        id = 0;
        inherit  extensions extraConfig;
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
