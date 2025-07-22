{ pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    # default = true;
    package = pkgs.firefox-devedition;
    nativeMessagingHosts.packages = with pkgs; [
      web-eid-app
    ];
    # preferences = {
    #   "browser.aboutConfig.showWarning" = false;
    #   "browser.tabs.firefox-view" = false;
    #   "browser.ml.chat.enabled" = false; # Disables AI
    #   "extensions.activeThemeID" = "{32aac792-0421-4e99-917a-c849311377ce}";
    #   "sidebar.revamp" = true;
    #   "sidebar.visibility" = "hide-sidebar";
    #   "sidebar.main.tools" = "history";
    #   "sidebar.verticalTabs" = true;
    # };
    # autoConfig = ''
    #   defaultPref("sidebar.revamp", true);
    #   defaultPref("sidebar.verticalTabs", true);
    # '';
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      SearchSuggestEnable = false;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      # FUCK OFF
      SearchEngines = {
        Add = [
          {
            Name = "Nix Packages";
            Description = "Nix Packages";
            IconURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            Method = "GET";
            Alias = "@np";
            URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
          }
          {
            Name = "Nix Options";
            URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
            Method = "GET";
            IconURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            Alias = "@no";
          }
          {
            Name = "NixOS Wiki";
            URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            Method = "GET";
            IconURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            Alias = "@nw";
          }
        ];
      };
      ExtensionSettings = {
        "{32aac792-0421-4e99-917a-c849311377ce}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4381091/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "languagetool-webextension@languagetool.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/languagetool/latest.xpi";
          installation_mode = "force_installed";
        };
        "{e68418bc-f2b0-4459-a9ea-3e72b6751b07}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4079746/web_eid_webextension-latest.xpi";
          installation_mode = "force_installed";
        };
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4470107/refined_github-latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
