{ self, inputs, ... }: {
  flake.nixosConfigurations.voyage = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.voyage
      self.nixosModules.preserve
      inputs.pinnacle.nixosModules.default
      self.nixosModules.graphics
      self.nixosModules.android
      # self.nixosModules.base
      self.nixosModules.losfelt
    ];
  };
  flake.nixosModules.voyage =
    {
      pkgs,
      ...
    }:

    {
      system.stateVersion = "26.11"; # Did you read the comment?
      losfelt = {
        programs = {
          firefox.enable = true;
          steam.enable = true;
          electronics.enable = true;
          development.enable = true;
          cryptoshit.enable = true;
        };
        system = {
          type = "laptop";
          boot = {
            emulatedSystems = [
              "armv7l-linux"
              "aarch64-linux"
            ];
          };
          timeZone = "Europe/Tallinn";
          nix.engine = "lix";
          kernel = {
            flavour = "xanmod";
            track = "latest";
          };
          zfs.channel = "unstable";
        };
        hardware = {
          bluetooth.enable = true;
          fingerprint.enable = true;
          amd.enable = true;
          audio = {
            enable = true;
            engine = "pipewire";
          };
        };
        networking = {
          identity = {
            name = "voyage";
            id = "4e98920d";
          };
          wifi.enable = true;
          tailscale.enable = true;
          ssh = {
            enable = true;
            reachableFrom = [ "tailnet" ];
          };

        };
        users = {
          heisfer = {
            fullName = "Heisfer Light";
            hashedPassword = "$y$j9T$wXkWhvdCXo4z23wxxzFy7.$ehIG6asiMMnjGV/8adlfMMjdHJuVG3tnNRdULvvvbYC";
            groups = [
              "wheel"
              "networkmanager"
              "kvm"
              "disk"
            ];
          };
        };
      };

      disabledModules = [ "programs/wayland/pinnacle.nix" ];

      # Use the systemd-boot EFI boot loader.

      # networking.hostName = "voyage"; # Define your hostname.
      # networking.hostId = "4e98920d";

      # # Configure network connections interactively with nmcli or nmtui.
      # networking.networkmanager.enable = true;

      environment.systemPackages = with pkgs; [
        brightnessctl
        kitty
        alacritty
        nixd
        multiviewer-for-f1
        nixfmt
        tree
        pear-desktop
      ];

    };

}
