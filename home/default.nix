{ inputs, config, pkgs, imports, lib, ... }:

let
  localPkgs = import ../pkgs/default.nix { pkgs = pkgs; };

  customPkgs = with localPkgs; [
    miru
    webcord-vencord
  ];

  dev = with pkgs; [
    nodePackages_latest.intelephense
    symfony-cli
    python3
    jq    
  ];

  apps = with pkgs; [
    chromium
    telegram-desktop
    transmission-qt
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

    ./firefox
    ./wezterm
    ./wayland/hyprland
    ./git
    ./starship
    ./editors/helix
    ./editors/neovim
    ./xplr.nix
  ];
  home.packages = customPkgs ++ dev ++ apps ++ utils ++ appsOverride;

  programs = {
    vscode = {
      enable = true;
    };

  };


  programs.bash = {
    enable = true;
  };

}
