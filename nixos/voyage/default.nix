# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  lib,
  inputs,
  pkgs,
  config,
  self',
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./virtual.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    plymouth.enable = true;
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      timeout = 0; # Just keep pressing random key until menu comes;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };
  programs.nh.enable = true;

  nixpkgs = {
    overlays = [ inputs.nur.overlay ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://devenv.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      extra-platforms = config.boot.binfmt.emulatedSystems;
    };
  };

  networking = {
    hostName = "voyage"; # Define your hostname.
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #  console = {
  #    font = "Lat2-Terminus16";
  #    keyMap = "us";
  #    useXkbConfig = true; # use xkb.options in tty.
  #  };

  programs = {
    steam.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    adb.enable = true;
  };
  users.extraUsers.greeter = {
    packages = [ self'.packages.rose-pine-gtk-theme ];
    home = "/tmp/greeter-home";
    createHome = true;
  };
  virtualisation.waydroid = {
    enable = true;
  };
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-s"
      "-m"
      "last"
    ];
    settings = {
      background = {
        path = "${inputs.wallpapers}/rose-pine.jpg";
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = lib.mkDefault "Bibata-Modern-Classic";
        icon_theme_name = lib.mkDefault "Adwaita";
        theme_name = lib.mkDefault "RosePine-Main-B-LB";
      };
    };
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security = {
    tpm2.enable = true;
    tpm2.pkcs11.enable = true;
    tpm2.tctiEnvironment.enable = true;

    polkit.enable = true;
    pam.services.hyprlock.text = "auth include login";
    rtkit.enable = true;
  };
  hardware = {
    firmware = [ pkgs.sof-firmware ];
    bluetooth = {
      enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services = {
    upower.enable = true;
    ath11k-sleep.enable = true;
    # polkit-gnome.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };
    fprintd.enable = true;
    pcscd.enable = true;
    gnome.gnome-keyring.enable = true;
    fwupd.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Tell p11-kit to load/proxy opensc-pkcs11.so, providing all available slots
  # (PIN1 for authentication/decryption, PIN2 for signing).
  environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.heisfer = {
    initialPassword = "password";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "adbusers"
      "libvirtd"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
    packages = with pkgs; [
      firefox
      git
      nano
      vim
      tree
    ];
  };

  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts
    noto-fonts-cjk
    noto-fonts-monochrome-emoji
    (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ sbctl ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
