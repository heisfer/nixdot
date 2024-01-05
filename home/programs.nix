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
    devdocs-desktop
    themix-gui
    minecraft
    signal-desktop
    planify
    gnome.nautilus
    xplorer
    cinny-desktop
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
    v4l-utils
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
    nitch
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
  home.packages = local ++ dev ++ apps ++ utils ++ appsOverride ++ libs ++ games;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
