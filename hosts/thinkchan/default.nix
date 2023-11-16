{pkgs, ...}: {
  imports = [
    # audio
    ./audio/bluetooth.nix
    ./audio/pipewire.nix

    # services
    ./service/ath11k.nix
#    ./service/greetd.nix
    #wayland
    ./wayland/env.nix
    ./wayland/portal.nix

    # misc
    ./misc/android.nix
    ./misc/nix.nix

    ./hardware-configuration.nix
  ];

  nixpkgs = {
    config = {
      allowsUnfree = true;
    };
  };

  systemd = {
    # sleep.extraConfig = ''
    #   SuspendState=freeze
    # '';
    services = {
      seatd = {
        enable = true;
        description = "Seat management daemon";
        script = "${pkgs.seatd}/bin/seatd -g wheel";
        serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = "1";
        };
        wantedBy = ["multi-user.target"];
      };
    };
  };

  programs.firefox.nativeMessagingHosts.euwebid = true;
  services = {
    fprintd.enable = true;
    upower.enable = true;
    fwupd.enable = true;
    pcscd = {
      enable = true;
    };
    gnome.gnome-keyring.enable = true;

    openssh.enable = true;
    gvfs.enable = true;
    xserver = {
      layout = "us";
      videoDrivers = ["amdgpu"];
      xkbModel = "pc105";
      xkbVariant = "colemak";
    };
  };
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  networking = {
    hostName = "thinkchan";
    networkmanager = {
      enable = true;
    };
  };

  security = {
    polkit.enable = true;
    pam.services.gtklock.text = "auth include login";
  };
  environment.systemPackages = [
    # winetricks (all versions)
    pkgs.winetricks

    pkgs.rpcs3

    pkgs.genymotion

    pkgs.glfw-wayland-minecraft

    # native wayland support (unstable)
    pkgs.wineWowPackages.waylandFull
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables = {
    # VAAPI and VDPAU config for accelerated video.
    # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };

  time.timeZone = "Europe/Tallinn";

  fonts = {
    packages = with pkgs; [
      # icon fonts
      font-awesome
      material-symbols
      # normal fonts
      jost
      lexend
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto

      # nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
  environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';
  users.users = {
    heisfer = {
      isNormalUser = true;
	  shell = pkgs.nushell;
      description = "Heisfer Light";
      extraGroups = ["wheel" "networkmanager" "audio" "video" "adbusers"];
    };
  };

  console.useXkbConfig = true;
  system.stateVersion = "23.05";
}
