{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.rycee-nurpkgs.lib.${pkgs.system}) buildFirefoxXpiAddon;
  extensions = with inputs.rycee-nurpkgs.packages.${pkgs.system}; [
    bitwarden
    darkreader
    privacy-badger
    sponsorblock
    tabcenter-reborn
    tree-style-tab
    tabliss
    translate-web-pages
    ublock-origin
    web-eid
  ];
in {
  home.file = {
    firefox-cascade = {
      target = ".mozilla/firefox/dev-edition-default/chrome/cascade";
      source = "${inputs.firefox-cascade}/chrome/includes";
    };
    firefox-tcr = {
      target = ".mozilla/firefox/dev-edition-default/chrome/cascade-tcr.css";
      source = "${inputs.firefox-cascade}/integrations/tabcenter-reborn/cascade-tcr.css";
    };
    firefox-rose-pine = {
      target = ".mozilla/firefox/dev-edition-default/chrome/cascade-rose-pine.css";
      source = "${inputs.firefox-cascade}/integrations/rose-pine/cascade-rose-pine.css";
    };
  };

  programs.firefox = {
    enable = true;

    package = pkgs.firefox-devedition.override {
      nativeMessagingHosts = [pkgs.web-eid-app];
      extraPolicies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
    };

    profiles.dev-edition-default = {
      id = 0;
      inherit extensions;

      search = {
        force = true;
        engines = {
          "Bing".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;

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
        };
      };
      userChrome = ''
        @import 'cascade/cascade-config.css';
        @import 'cascade/cascade-layout.css';
        @import 'cascade/cascade-responsive.css';
        @import 'cascade/cascade-floating-panel.css';
        @import 'cascade/cascade-nav-bar.css';
        @import 'cascade/cascade-tabs.css';
        @import 'cascade-tcr.css';
        @import 'cascade-rose-pine.css';

      '';
      settings = {
        "browser.fullscreen.autohide" = false;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "extensions.pocket.enabled" = false;
        "extensions.pocket.showHome" = false;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
