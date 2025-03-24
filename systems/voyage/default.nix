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
  loadNixFiles =
    dir:
    lib.flatten (
      lib.mapAttrsToList (
        name: type:
        if type == "directory" then
          loadNixFiles (dir + "/${name}")
        else if name == "default.nix" then
          dir + "/${name}"
        else
          [ ]
      ) (builtins.readDir dir)
    );
  system = pkgs.system;
  nixpkgs-fprint-fix = pkgs.fetchFromGitHub {
    owner = "pineapplehunter";
    repo = "nixpkgs";
    rev = "9f9f51f10007131b1d7c94a2072264b0c1e0f52d";
    hash = "sha256-vbVTT+2holgA4t6n6eVyTC6YwVxGOLS9sdRiRegtJpw=";
  };
  pr389711 = import nixpkgs-fprint-fix {
    inherit system;
    config.allowUnfree = true;
  };
in

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./tpm2.nix
      ./fonts.nix
      ./silentboot.nix
      ../../nixos/services/polkit.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules
    ++ loadNixFiles ../../userspace;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  nix = {
    channel.enable = false;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.flake.setFlakeRegistry = true;
  nixpkgs.config.allowUnfree = true;

  services.playerctld.enable = true;

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = false;

  networking.hostId = "4e98920d";
  networking.hostName = "voyage"; # Define your hostname.
  # networking.useDHCP = false;
  # networking.dhcpcd.enable = false;
  # networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  # networking.networkmanager.wifi.backend = "iwd";
  # networking.networkmanager.wifi.powersave = false;
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
    "2620:fe::fe"
    "2620:fe::9"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  services.tailscale.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.greetd.enable = true;
  services.greetd.settings =
    let
      start = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop > /dev/null"; # dev/null for no messages on the screen
        user = "heisfer";
      };
    in
    {
      initial_session = start;
      default_session = start;
    };

  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.fprintd.enable = true;
  services.fprintd.package = pr389711.fprintd-tod;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.heisfer = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "tss"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
  };

  programs.nh = {
    enable = true;
    flake = "/home/heisfer/Projects/system/dots";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    wget
    tree
    kitty
    unzip
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
    tutanota-desktop
    # rbw
    rbw
    pinentry-rofi

    kdiskmark

  ];

  services.flatpak.enable = true;

  services.auto-cpufreq.enable = true;

  environment.shellInit = ''
    function __zoxide_zih() {
      \builtin local result
      result="$(\command zoxide query -i -- "$@")" && __zoxide_cd "$result"
      _direnv_hook
      hx .
    }
    function __zoxide_zh() {
      __zoxide_z "$@"
      _direnv_hook
      hx .
    }

    alias zh=__zoxide_zh
    alias zih=__zoxide_zih
  '';
  services.dbus.packages = [ pkgs.kdiskmark ];
  security = {
    sudo.enable = false;
    sudo-rs.enable = true;
    sudo-rs.execWheelOnly = true;
  };

  system.stateVersion = "25.05"; # Did you read the comment?

}
