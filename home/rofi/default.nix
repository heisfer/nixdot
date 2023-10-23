{pkgs, ...}: {
    programs.rofi = {
        enable = true;
        font = "Comic Code Ligatures 14";
        package = pkgs.rofi-wayland;
        plugins = with pkgs; [
            rofi-calc
            rofi-rbw
        ];
    };
    xdg.configFile."rofi".source = ./config;
}