{
  pkgs,
  inputs,
  ...
}: let
  extensions = with inputs.rycee-nurpkgs.packages.${pkgs.system}; [
    ublock-origin
    sidebery
    bitwarden
    darkreader
    privacy-badger
    sponsorblock
    translate-web-pages
  ];
  extraConfig = ''
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    user_pref("browser.search.widget.inNavBar", false);
    user_pref("services.sync.prefs.sync.browser.urlbar.showSearchSuggestionsFirst", false);
  '';
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition.override {
      nativeMessagingHosts = [pkgs.web-eid-app];
      extraPolicies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
    };
    profiles = {
      dev-edition-default = {
        id = 0;
        inherit extensions extraConfig;
        settings = {
          "browser.fullscreen.autohide" = false;
        };
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
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };

            "Home-Manager" = {
              urls = [{template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";}];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hm"];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
      };
    };
  };
}
