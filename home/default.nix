{ inputs, config, pkgs, imports, lib, ... }:

let
  localPkgs = import ../pkgs/default.nix { pkgs = pkgs; };

  customPkgs = with localPkgs; [
    miru
    station
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
    onagre
    scrcpy
  ];

  appsOverride = with pkgs; [
    (discord.override {
      withVencord = true;
    })
  ];

  utils = with pkgs; [
    nerd-font-patcher
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


  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
  };
  
  programs.nushell ={
    enable = true;
  };
}
