{ inputs, config, pkgs, imports, lib, ... }:

let
  localPkgs = import ../pkgs/default.nix { pkgs = pkgs; };

  customPkgs = with localPkgs; [
    miru
  ];

  dev = with pkgs; [
    symfony-cli
    python3
    jq    
  ];

  apps = with pkgs; [
    chromium
    webcord-vencord
    telegram-desktop
    github-desktop
    transmission-qt
    kitty
    scrcpy
  ];

  appsOverride = with pkgs; [
    (discord.override {
      withVencord = true;
    })
  ];

  utils = with pkgs; [
    neofetch
    glxinfo
    grim
    htop
    slurp
    pamixer
    scrot
    pavucontrol
    libva-utils
    wf-recorder
    wl-clipboard
    dconf
    xorg.xeyes
    xorg.xrandr
    libnotify
  ];
  
in
{
  imports = [
    ./programs
    ./browser
    ./wayland/hyprland
    ./starship
    ./editors
  ];
  home.packages = customPkgs ++ dev ++ apps ++ utils ++ appsOverride;

  programs = {
    vscode = {
      enable = true;
    };

  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
  };

}
