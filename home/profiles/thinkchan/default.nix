{...}: {
  imports = [
    #internet
    ../../internet/firefox
    ../../internet/thunderbird
    #../internet/chromium -- I'll add this later

    #editors
    ../../editors
    ../../default.nix
    ../../wayland/hyprland
    ../../gtk

    #shell stuff
    ../../shell/bash
    ../../shell/nushell
    ../../shell/starship
    ../../shell/xplr
    ../../shell/git

    ../../programs/kitty
    ../../programs/wezterm
  ];

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

  home = {
    username = "heisfer";
    homeDirectory = "/home/heisfer";
    stateVersion = "23.05";
  };
}
