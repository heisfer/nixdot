{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "BlexMono Nerd Font Mono:size=14:weight=medium";
        box-drawings-uses-font-glyphs = "yes";
        dpi-aware = false;
      };
      cursor = {
        color = "191724 e0def4";
        style = "beam";
        beam-thickness = "2px";
      };

      colors = {
        background = "191724";
        foreground = "e0def4";
        regular0 = "26233a"; # black (Overlay)
        regular1 = "eb6f92"; # red (Love)
        regular2 = "3e8fb0"; # green (Pine)
        regular3 = "f6c177"; # yellow (Gold)
        regular4 = "9ccfd8"; # blue (Foam)
        regular5 = "c4a7e7"; # magenta (Iris)
        regular6 = "ebbcba"; # cyan (Rose)
        regular7 = "e0def4"; # white (Text)

        bright0 = "6e6a86"; # bright black (Overlay)
        bright1 = "eb6f92"; # bright red (Love)
        bright2 = "3e8fb0"; # bright green (Pine)
        bright3 = "f6c177"; # bright yellow (Gold)
        bright4 = "9ccfd8"; # bright blue (Foam)
        bright5 = "c4a7e7"; # bright magenta (Iris)
        bright6 = "ebbcba"; # bright cyan (Rose)
        bright7 = "e0def4"; # bright white (Text)
      };
    };
  };
}
