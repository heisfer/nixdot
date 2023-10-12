{pkgs, ...}: {
    programs.rofi = {
        enable = true;
        font = "Comic Code Ligatures 14";
        package = pkgs.rofi-wayland.override {
            plugins = with pkgs; [
              rofi-rbw
              rofi-bluetooth
            ];
        };
    };
    xdg.configFile."rofi".source = ./config;
}