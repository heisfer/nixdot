{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = ["hyprland/workspaces"];

        "hyprland/workspaces" = {
          "format" = "{name}";
        };
      };
    };
  };
}
