{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.vesktop;

  jsonFormat = pkgs.formats.json { };

in
{
  options = {
    programs.vesktop = {
      enable = lib.mkEnableOption "Whether to enable vekstop";

      package = lib.mkPackageOption pkgs "vesktop" { };

      withSystemVencord = lib.mkEnableOption "Whether to use system vencord package";

      settings = lib.mkOption {
        type = jsonFormat.type;
        default = { };
        example = lib.literalExpression ''
          {
            autoUpdate = false;
            autoUpdateNotification = false;
            # semi-required if you use theme
            enabledThemes = [ "themes.css" ]; 
            plugin = {
               AlwaysAnimate.enabled = true;
               WebContextMenus = {
                enabled = true;
                addBack = true;
              };
            };
          }
        '';
      };

      theme = lib.mkOption {
        default = null;
        type =
          with lib.types;
          nullOr (oneOf [
            lines
            path
          ]);
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ (cfg.package.override { withSystemVencord = cfg.withSystemVencord; }) ];

    xdg.configFile = {
      "vesktop/settings/settings.json".source = jsonFormat.generate "vesktop-settings" cfg.settings;

      "vesktop/themes/theme.css" = lib.mkIf (cfg.theme != null) {
        source =
          if builtins.isPath cfg.theme || lib.isStorePath cfg.theme then
            cfg.theme
          else
            pkgs.writeText "vesktop/themes/theme.css" cfg.theme;
      };
    };

  };
}
