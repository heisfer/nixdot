{ inputs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "${inputs.wallpapers}/rose-pine-nix.png";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -300";
          placeholder_text = "<i>Fingerprint</i>";
          outer_color = "rgb(25, 23, 36)";
          inner_color = "rgb(31, 29, 46)";
          font_color = "rgb(224, 222, 244)";
          check_color = "rgb(246, 193, 119)";
          fail_color = "rgb(235, 111, 146)";
        }
      ];
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_family = "IBM Plex";
          font_size = 50;
          color = "rgb(235, 188, 186)";

          position = "-550, 450";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
