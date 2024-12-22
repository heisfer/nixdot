{ inputs, ... }:
{
  imports = [ inputs.dotmod.homeManagerModules.default ];

  programs.vesktop = {
    enable = true;
    # same as veskord/settings/settings.json
    settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = false;
      enabledThemes = [
        "theme.css"
      ];
      plugins = {
        NoTrack.enabled = true;
        Settings.enabled = true;
        WebContextMenus.enabled = true;
        WhoReacted.enabled = true;
        Translate.enabled = true;
        BetterFolders.enabled = true;
        ImageZoom.enabled = true;
        FakeNitro.enabled = true;
        "WebRichPresence (arRPC)".enabled = true;
        Typingtweaks.enabled = true;
        PlatformIndicators.enabled = true;
        QuickMention.enabled = true;
        MentionAvatars.enabled = true;
      };
    };
    withSystemVencord = true;
    themes = {
      rosover = ''
        test
      '';
      rose-pine = ''
        bervin
        dsafsda
        fdsafds
        afdsa
        fdsafdsa
        fdsa
      '';
    };
    #     quickCss = ''
    #           /**
    #        * @name Modular
    #        * @author SEELE1306
    #        * @authorLink https://github.com/SEELE1306
    #        * @description A highly customizable theme for Vesktop.
    #        * @license MIT
    #        * @version 2.1.1
    #        * @authorId 518795791318384647
    #        * @discord seele1306
    #        **/

    #       /* --- IMPORT MAIN FILE --- */

    #       @import url(https://raw.githubusercontent.com/SEELE1306/Modular/release/src/main.css);

    #       /* --- THIRD PARTY IMPORTS --- */
    #       /* Should you want to use snippets, place them here */

    #       /* --- CUSTOMIZABLE --- */

    #       :root {
    #         /*
    #       	* [[ BACKGROUND ]]
    #       	* Change to none for solid or add a background (must be an URL) */
    #         --modular-background: none !important;
    #         --modular-background-blur-strength: 10px;
    #         /* in px, Default is 10px */

    #         /* [[ DISCORD COLORS ]] */
    #         --modular-red: #eb6f92;
    #         --modular-yellow: #ebbcba;
    #         --modular-green: #31748f;
    #         --modular-orange: #f6c177;
    #         --modular-teal: #c4a7e7;
    #         --modular-blue: #31748f;

    #         /* [[ BASE COLORS ]] */
    #         --modular-bg0: #191724; /* Primary background color */
    #         --modular-bg1: #1f1d2e; /* Secondary background color */
    #         --modular-bg2: #151515; /* Tertiary background color */
    #         --modular-bg3: #1f1d2e; /* Quarterary background color */
    #         --modular-bg4: #26233a; /* Modifier/hover/select background color */

    #         --modular-text0: #e0def4; /* Normal text color */
    #         --modular-text1: #e0def4; /* Brighter text color */
    #         --modular-text2: #908caa; /* Darker text color */

    #         /* [[ BRAND COLORS ]] */
    #         --modular-accent: #524f67; /* Accent color */
    #         --modular-flavor: "Rosebox"; /* Flavor name */

    #         /* [[ CHAT BUBBLES ]] */
    #         --modular-cb-width: max-content; /* 100% for chat bubbles spanning the entire screen / max-content for dynamic width, Default is max-content */

    #         /* [[ FONT CHANGE ]] */
    #         --font-main: "Inter";
    #         --font-code: "Roboto Mono";

    #         /* [[ CLIENT LAYOUT ]] */
    #         --client-border-color: var(--brand-500);
    #         --modular-sidebar-orientation: column;
    #         /* column-reverse for user panel on top */
    #         --modular-guild-orientation: row;
    #         /* row-reverse for guild bar on the right */
    #         --modular-memberlist-orientation: row;
    #         /* row-reverse for member list on the left */
    #         --modular-friendlist-orientation: row;
    #         /* row-reverse for now playing tab on the left */

    #         /* [[ SPOTIFY TRACK BACKGROUND ]] */
    #         --modular-spotify-bg-blur: 2px; /* higher px = stronger blur, 0 = no blur */
    #         --modular-spotify-darken: 0.5; /* 0 = album cover is not darkened, 1 = album cover is darkened fully (black) */
    #       }
    #     '';
  };

}
