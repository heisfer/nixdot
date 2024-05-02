{config, ...}: {
  programs.hyprlock = {
    enable = true;
    general = {
      disable_loading_bar = true;
      hide_cursor = true;
    };

    backgrounds = [
      {
        monitor = "";
        path = "${config.home.homeDirectory}/cat.png";
      }
    ];
    input-fields = [
      {
        outer_color = "rgb(25, 23, 36)";
        inner_color = "rgb(31, 29, 46)";
        font_color = "rgb(224, 222, 244)";
        check_color = "rgb(246, 193, 119)";
        fail_color = "rgb(235, 111, 146)";
      }
    ];
    labels = [
      {
        monitor = "";
        text = "$TIME";
        font_family = "IBM Plex";
        font_size = 50;
        color = "rgb(235, 188, 186)";

        position = {
          x = 0;
          y = 80;
        };

        valign = "center";
        halign = "center";
      }
    ];
  };
}
