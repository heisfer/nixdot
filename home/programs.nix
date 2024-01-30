{
  pkgs,
  inputs,
  ...
}: let
  local = with inputs.self.packages.${pkgs.system}; [
    miru
  ];
  games = with pkgs; [
    steam
    runelite
    tetrio-desktop
  ];

  dev = with pkgs; [
    phpactor
    go
    jq
    python3
    symfony-cli
  ];

  libs = with pkgs; [
    glibc
    libdigidocpp
    glfw-wayland
  ];

  apps = with pkgs; [
    chromium
    cinny-desktop
    devdocs-desktop
    tutanota-desktop
    vesktop
    github-desktop
    gnome.nautilus
    kitty
    minecraft
    onagre
    onlyoffice-bin
    planify
    qdigidoc
    scrcpy
    signal-desktop
    telegram-desktop
    themix-gui
    transmission-qt
    webcord-vencord
    xplorer
    youtube-music
  ];

  appsOverride = with pkgs; [
    (discord.override {
      withVencord = true;
    })
    (prismlauncher.override {
      jdks = with pkgs; [
        temurin-jre-bin-8
        temurin-jre-bin-17
      ];
      glfw = pkgs.glfw-wayland-minecraft;
    })
    (
      floorp.override {
        nativeMessagingHosts = [pkgs.web-eid-app];
        # extraPolicies.SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
      }
    )
  ];

  utils = with pkgs; [
    swww
    inotify-tools
    jellyfin-ffmpeg
    xdg-utils
    dconf
    gtop
    grim
    htop
    unzip
    ripgrep
    p7zip
    rar
    scrcpy
    zip
    pavucontrol
    libnotify
    neofetch
    nitch
    nerd-font-patcher
    pamixer
    pavucontrol
    scrot
    slurp
    wf-recorder
    wl-screenrec
    wl-clipboard
  ];
in {
  home.packages = local ++ dev ++ apps ++ utils ++ appsOverride ++ libs ++ games;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-gstreamer
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs
    ];
  };
}
