{
  lib,
  config,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types)
    attrsOf
    bool
    either
    int
    ints
    listOf
    nullOr
    package
    str
    ;
  inherit (lib.modules) mkIf mkDefault mkMerge;
  inherit (lib.generators) toINI;
  inherit (lib.trivial) boolToString;
  inherit (lib.strings) escape;
  inherit (lib.attrsets) optionalAttrs;
  inherit (lib.lists) optionals;

  cfg = config.ui.gtk;

  gtkINI = toINI {
    mkKeyValue =
      key: value:
      let
        value' = if builtins.isBool value then boolToString value else toString value;
      in
      "${escape [ "=" ] key}=${value'}";
  };

  gtkSettings =
    optionalAttrs (cfg.theme.name != null) {
      gtk-theme-name = cfg.theme.name;
    }
    // optionalAttrs (cfg.cursorTheme.name != null) {
      gtk-cursor-theme-name = cfg.cursorTheme.name;
    }
    // optionalAttrs (cfg.cursorTheme.size != null) {
      gtk-cursor-theme-size = cfg.cursorTheme.size;
    };

in
{
  # For dconf settings refer to programs.dconf nixos options.
  options.ui.gtk = {
    enable = mkEnableOption "gtk";
    enableDark = mkEnableOption "gtk dark mode";
    theme = {
      name = mkOption {
        type = nullOr str;
        default = null;
        description = "Primary GTK theme name";
      };
      packages = mkOption {
        type = listOf package;
        default = [ ];
        description = "List of GTK themes";
      };
    };
    cursorTheme = {
      name = mkOption {
        type = nullOr str;
        default = null;
        description = "Primary GTK cursor theme name";
      };
      size = mkOption {
        type = nullOr ints.unsigned;
        default = null;
        example = 32;
        description = "The size of cursor";
      };
      packages = mkOption {
        type = listOf package;
        default = [ ];
      };
    };
    gtk3.settings = mkOption {
      type = attrsOf (either bool (either int str));
      default = { };
      description = "GTK3 settings";
      example = {
        gtk-application-prefer-dark-theme = true;
      };
    };
    gtk4.settings = mkOption {
      type = attrsOf (either bool (either int str));
      default = { };
      description = "GTK4 settings";
      example = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
  config = mkIf cfg.enable {

    environment.systemPackages =
      optionals (cfg.theme.packages != [ ]) cfg.theme.packages
      ++ optionals (cfg.cursorTheme.packages != [ ]) cfg.cursorTheme.packages;

    environment.etc."gtk-4.0/settings.ini".text = gtkINI {
      Settings = gtkSettings // cfg.gtk4.settings;
    };
    environment.etc."gtk-3.0/settings.ini".text = gtkINI {
      Settings = gtkSettings // cfg.gtk3.settings;
    };
    environment.variables.GTK_THEME = mkIf (cfg.theme.name != null) cfg.theme.name; # Needed for some applications
    environment.variables.XCURSOR_THEME = mkIf (cfg.cursorTheme.name != null) cfg.cursorTheme.name;
    environment.variables.XCURSOR_SIZE = mkIf (cfg.cursorTheme.size != null) cfg.cursorTheme.size;

    # DAFUCK IS THIS????? WHY I HAVE TO IT LIKE THAT???
    programs.dconf = {
      enable = mkDefault true;
      profiles = {
        user.databases = mkMerge [
          (lib.mkIf (cfg.enableDark) [
            {
              lockAll = true;
              settings = {
                "org/gnome/desktop/interface" = {
                  color-scheme = "prefer-dark";
                };
              };
            }
          ])
          (mkIf (cfg.cursorTheme.name != null) [
            {
              lockAll = true;
              settings = {
                "org/gnome/desktop/interface" = {
                  cursor-theme = cfg.cursorTheme.name;
                };
              };
            }
          ])
          (mkIf (cfg.cursorTheme.size != null) [
            {
              lockAll = true;
              settings = {
                "org/gnome/desktop/interface" = {
                  cursor-size = lib.gvariant.mkInt32 cfg.cursorTheme.size;
                };
              };
            }
          ])
        ];
      };
    };
  };

}
