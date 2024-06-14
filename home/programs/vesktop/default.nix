{
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
    theme = ./rose-pine.theme.css;

    # You can also use it like this:
    # theme = ''
    # Css stuff here
    # '';
  };
}
