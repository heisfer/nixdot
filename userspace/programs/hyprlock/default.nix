{ inputs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "${inputs.wallpapers}/deskresearch.png";
        blur_passes = 1;
        blur_size = 2;
      };

      auth = {
        pam.enabled = true;
        fingerprint = {
          enabled = true;
          ready_message = "";
          present_message = "Test2";
        };
      };

      input-field = [
        {
          size = "50, 50";
          position = "0, -40%";
          fade_on_empty = false;
          swap_font_color = true;
          hide_input = true;
          fail_text = "<span font_size='20pt'>󰺱</span>";
          outline_thickness = 5;
          font_family = "BlexMono Nerd Font Propo";
          placeholder_text = "<span font_size='20pt'>󰈷</span>";
          outer_color = "rgb(25, 23, 36)";
          inner_color = "rgb(31, 29, 46)";
          fail_color = "rgb(235, 111, 146)";
          check_color = "rgb(246, 193, 119)";
          font_color = "rgb(224, 222, 244)";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_family = "BlexMono Nerd Font Propo";
          font_size = 50;
          color = "rgb(235, 188, 186)";

          position = "0, 40%";

          valign = "center";
          halign = "center";
        }
      ];
    };

  };
}
