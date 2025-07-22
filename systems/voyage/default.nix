# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.dotmod.extra) loadNixFiles;
in

{
  imports = [
    # Include the results of the hardware scan.
    ./android.nix
    ./hardware-configuration.nix
    ./tpm2.nix
    ./fonts.nix
    ../../nixos/services/polkit.nix
    # ../../userspace/default.nix
  ]
  ++ lib.filesystem.listFilesRecursive ../../modules
  ++ loadNixFiles ../../userspace;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.silent.enable = true;

  boot.secureboot.enable = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.hid-tmff2 ];
    kernelModules = [ "hid-tmff-new" ];
  };
  services.udev.packages = [ pkgs.oversteer ];
  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-experimental-features = [
        "pipe-operators"
      ];
      warn-dirty = false;
      accept-flake-config = true;
    };
  };

  services.fwupd.enable = true;
  nixpkgs.flake.setFlakeRegistry = true;
  nixpkgs.config.allowUnfree = true;

  services.playerctld.enable = true;

  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # For appimages unzip
  programs.nix-ld.enable = true;

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = false;

  networking.hostId = "4e98920d";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.powersave = false;
  networking.networkmanager.wifi.scanRandMacAddress = false;

  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
    "2620:fe::fe"
    "2620:fe::9"
  ];
  services.gvfs.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  services.tailscale.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # services.nixos-cli = {
  #   enable = true;
  # config = {

  # };
  # };

  # services.greetd.enable = true;
  # services.greetd.settings =
  #   let
  #     start = {
  #       command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop > /dev/null"; # dev/null for no messages on the screen
  #       user = config.userspace.defaultUser;
  #     };
  #   in
  #   {
  #     initial_session = start;
  #     default_session = start;
  #   };

  userspace.loginmanager = {
    enable = true;
    default = {
      hyprland.enable = true;
      niri.enable = true;
    };
  };
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.fprintd.enable = true;
  services.fprintd.package = pkgs.fprintd-tod;
  # services.fprintd.package = pr389711.fprintd-tod;

  userspace.users.heisfer = {
    isDefault = true;
    isTrusted = true;
    enableHjem = true;
    groups = [
      "wheel"
      "tss"
      "networkmanager"
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.TERMINAL = config.programs.ghostty.package.pname;
  environment.systemPackages = with pkgs; [
    asciinema
    wget
    amdgpu_top
    lm_sensors
    tree
    bitwarden-desktop
    unzip
    rar
    nwjs
    unrar
    legcord
    (discord.override {
      withOpenASAR = true;
    })
    youtube-music
    wl-clipboard
    freetube
    krita
    element-desktop
    github-desktop
    gh
    gitify
    nixpkgs-review
    oversteer
    tutanota-desktop
    # rbw
    rbw
    pinentry-rofi
    miru

    kdiskmark
    imv
    mpv
    htop
    termusic
    zellij
    # just desiding
    nautilus
    kdePackages.ark
    kdePackages.dolphin
    # local.code2prompt

    # inputs.nvf.packages.${pkgs.system}.default
    nix-fast-build
    nix-output-monitor

    # local.floorp

    (pkgs.writers.writePython3Bin "krisp-patcher"
      {
        libraries = with pkgs.python3Packages; [
          capstone
          pyelftools
        ];
        flakeIgnore = [
          "E501" # line too long (82 > 79 characters)
          "F403" # 'from module import *' used; unable to detect undefined names
          "F405" # name may be undefined, or defined from star imports: module
        ];
      }
      (
        builtins.readFile (
          pkgs.fetchurl {
            url = "https://pastebin.com/raw/8tQDsMVd";
            sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
          }
        )
      )
    )
  ];

  services.xserver = {
    enable = true;
    autorun = false;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    displayManager = {
      startx.enable = true;
    };
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  services.gnome.gnome-keyring.enable = true;

  services.flatpak.enable = true;

  services.clamav = {
    daemon.enable = true;
    scanner.enable = true;
    updater.enable = true;
  };
  services.auto-cpufreq.enable = true;

  services.wordpress.sites."localhost" = { };

  services.dbus.packages = [ pkgs.kdiskmark ];
  security = {
    sudo.enable = false;
    sudo-rs.enable = true;
    sudo-rs.execWheelOnly = true;
  };
  documentation.man.generateCaches = false;

  system.stateVersion = "25.05"; # Did you read the comment?

}
