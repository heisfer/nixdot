{ inputs, ... }:
let
  rose-pine = ".config/alacritty/rose-pine.toml";
in
{
  home.file = {
    alacritty-rose-pine = {
      target = rose-pine;
      source = inputs.alacritty-rose-pine + /dist/rose-pine.toml;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      import = [ rose-pine ];
      window = {
        padding = {
          x = 5;
          y = 5;
        };
        dimensions = {
          lines = 3;
          columns = 200;
        };
      };
      font = {
        size = 13;
        normal = {
          family = "BlexMono Nerd Font Mono";
          style = "Medium";
        };
      };
      cursor = {
        style = {
          shape = "Beam";
        };
        thickness = 1;
      };
      keyboard.bindings = [

        {
          key = "K";
          mods = "Control";
          chars = "\\u000c";
        }
      ];
    };
  };
}
