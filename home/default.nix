{pkgs, ...}: let
  localPkgs = import ../pkgs/default.nix {pkgs = pkgs;};

  customPkgs = with localPkgs; [
    wavebox
    miru
  ];

  games = with pkgs; [
    steam
    runelite
  ];

  dev = with pkgs; [
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
    github-desktop
    kitty
    onagre
    qdigidoc
    scrcpy
    youtube-music
    telegram-desktop
    transmission-qt
    webcord-vencord
  ];

  appsOverride = with pkgs; [
    (discord.override {
      withVencord = true;
    })
    (prismlauncher.override {
      glfw = let
        mcWaylandPatchRepo = fetchFromGitHub {
          owner = "Admicos";
          repo = "minecraft-wayland";
          rev = "370ce5b95e3ae9bc4618fb45113bc641fbb13867";
          sha256 = "sha256-RPRg6Gd7N8yyb305V607NTC1kUzvyKiWsh6QlfHW+JE=";
        };
        mcWaylandPatches =
          map (name: "${mcWaylandPatchRepo}/${name}")
          (lib.naturalSort (builtins.attrNames (lib.filterAttrs
            (name: type: type == "regular" && lib.hasSuffix ".patch" name)
            (builtins.readDir mcWaylandPatchRepo))));
      in
        glfw-wayland.overrideAttrs (previousAttrs: {
          patches = previousAttrs.patches ++ mcWaylandPatches;
        });
    })
  ];

  utils = with pkgs; [
    jellyfin-ffmpeg
    xdg-utils
    dconf
    gtop
    glxinfo
    grim
    htop
    unzip
    p7zip
    rar
    scrcpy
    zip
    pavucontrol
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
    ./internet
    ./editors
    ./programs
    ./wayland/hyprland
  ];
  home.packages = customPkgs ++ dev ++ apps ++ utils ++ appsOverride ++ libs ++ games;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
