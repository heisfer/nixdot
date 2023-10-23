{
    programs.kitty  = {
        enable = true;
        extraConfig = builtins.readFile ./wezterm.lua;
    };
}