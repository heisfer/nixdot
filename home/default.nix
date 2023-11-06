{pkgs, ...}: let
  localPkgs = import ../pkgs/default.nix {pkgs = pkgs;};

  customPkgs = with localPkgs; [
    miru
  ];

  dev = with pkgs; [
    jq
    python3
    symfony-cli
  ];

  libs = with pkgs; [
    libdigidocpp
  ];

  apps = with pkgs; [
    chromium
    github-desktop
    kitty
    onagre
    qdigidoc
    scrcpy
    telegram-desktop
    transmission-qt
    webcord-vencord
  ];

  appsOverride = with pkgs; [
    (discord.override {
      withVencord = true;
    })
  ];

  utils = with pkgs; [
    dconf
    glxinfo
    grim
    htop
    libnotify
    libva-utils
    neofetch
    nerd-font-patcher
    pamixer
    pavucontrol
    scrot
    slurp
    wf-recorder
    wl-clipboard
    xorg.xeyes
    xorg.xrandr
  ];
in {
  imports = [
    ./browser
    ./editors
    ./programs
    ./starship
    ./wayland/hyprland
  ];
  home.packages = customPkgs ++ dev ++ apps ++ utils ++ appsOverride ++ libs;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
  };

  programs.nushell = {
    enable = true;
  };
}
