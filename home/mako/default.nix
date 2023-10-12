{
    services.mako = {
        enable = true;
        extraConfig = builtins.readFile ./config;
    };
}