{ pkgs, ... }:
let
  firefox-addons = pkgs.nur.repos.rycee.firefox-addons;
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles.dev-edition-default = {
      extensions = with firefox-addons; [
        ublock-origin
        bitwarden
        languagetool
        web-eid
      ];
    };
  };
}
