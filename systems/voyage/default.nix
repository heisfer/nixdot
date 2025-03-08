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

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./tpm2.nix
      ./fonts.nix
      ./compositor/hyprland.nix
      ./compositor/hyprpaper.nix
      ./compositor/waybar
    ]
    ++ lib.filesystem.listFilesRecursive ../../modules
    ++ lib.filesystem.listFilesRecursive ../../userspace;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = false;

  networking.hostId = "4e98920d";
  networking.hostName = "voyage"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  services.tailscale.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.greetd.enable = true;
  services.greetd.settings =
    let
      start = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop"; # dev/null for no messages on the screen
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
  services.fprintd.package = pkgs.fprintd-tod;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.heisfer = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "tss"
    ]; # Enable ‘sudo’ for the user.
  };

  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-devedition;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    helix
    nixd
    nil
    kitty
    wofi
    bash-language-server
    unzip
    zoxide
    legcord
    youtube-music
    wl-clipboard
    # rbw
    rbw
    pkgs.pinentry-rofi
  ];

  programs.bash.interactiveShellInit = ''
    eval "$(zoxide init bash)"
  '';

  system.stateVersion = "25.05"; # Did you read the comment?

}
