{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition.override {
      nativeMessagingHosts = [
        pkgs.web-eid-app
        pkgs.keepassxc
      ];
      extraPolicies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
    };
    profiles.dev-edition-default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        web-eid
        bitwarden
        languagetool
        darkreader
        keepassxc-browser
      ];
      search = {
        force = true;
        engines = {
          "Bing".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Youtube  Music" = {
            urls = [ { template = "https://music.youtube.com/search?q={searchTerms}"; } ];
            definedAliases = [ "ym" ];
          };
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
                    name = "channel";
                    value = "unstable";
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
          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          "NixOS Wiki" = {
            urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Home-Manager" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@hm" ];
          };
        };
      };
      settings = {
        "browser.tabs.firefox-view" = false; # Disables the annyoing Firefox view
        "extensions.pocket.enabled" = false; # Disables firefox pocket
        "full-screen-api.ignore-widgets" = true; # Make videos full screen without being fullscreen
        "browser.tabs.closeWindowWithLastTab" = false; # Make so the browser doesn't close when last tab is closed
        "identity.fxaccounts.enabled" = false; # Disable Firefox accounts integration.
      };
    };
  };
}
