{ inputs, ... }:
{
  imports = [ inputs.dotmod.homeManagerModules.vesktop ];

  programs.vesktop = {
    enable = true;
    # same as veskord/settings/settings.json
    settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = false;
      enabledThemes = [ "theme.css" ];
      plugins = {
        NoTrack.enabled = true;
        Settings.enabled = true;
        WebContextMenus.enabled = true;
        WhoReacted.enabled = true;
        Translate.enabled = true;
        BetterFolders.enabled = true;
        ImageZoom.enabled = true;
        FakeNitro.enabled = true;
      };
    };
    withSystemVencord = true;
    theme = ./rose-pine.theme.css;
  };

}
