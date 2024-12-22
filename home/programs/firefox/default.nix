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
      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Home-manager OP" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
                  {
                    name = "release";
                    value = "master";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@hm" ];
          };

          "NixOS Wiki" = {
            urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
      };
    };

  };
}
