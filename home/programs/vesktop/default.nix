{
  programs.vesktop = {
    enable = true;
    # same as veskord/settings/settings.json
    settings = {
      autoUpdate = false;
      enabledThemes = [ "theme.css" ];
      plugins = {
        AlwaysAnimate.enabled = true;
      };
    };
    theme = ./rose-pine.theme.css;

    # You can also use it like this:
    # theme = ''
    # Css stuff here
    # '';
  };
}
