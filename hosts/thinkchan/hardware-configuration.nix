# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Boot
  # https://search.nixos.org/options?channel=unstable&show=boot
  boot = {

    # Boot - Initrd
    # https://search.nixos.org/options?channel=unstable&show=boot.initrd
    initrd = {

      # Boot - Initrd - Available Kernel Modules 
      # https://search.nixos.org/options?channel=unstable&show=boot.initrd.availableKernelModules
      availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];

      # Boot - Initrd - Kernel Modules
      # https://search.nixos.org/options?channel=unstable&show=boot.initrd.kernelModules
      kernelModules = [ "amdgpu" ];

      # Boot - Initrd - Verbose
      # https://search.nixos.org/options?channel=unstable&show=boot.initrd.verbose
      verbose = false;
    };

    # Boot - Loader
    # https://search.nixos.org/options?channel=unstable&show=boot.loader
    loader = {
      # Boot - Loader - System-dboot
      # https://search.nixos.org/options?channel=unstable&show=boot.loader.systemd-boot
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };

      # Boot - Loader - EFI
      # https://search.nixos.org/options?channel=unstable&show=boot.loader.efi
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 0;
    };

    # # Boot - Kernel Packages
    # https://search.nixos.org/options?channel=unstable&show=boot.kernelPackages
    kernelPackages = pkgs.linuxPackages_latest;


    # Boot - Kernel Modules
    # https://search.nixos.org/options?channel=unstable&show=boot.kernelModules
    kernelModules = ["amd-pstate" "kvm-amd"];

    # Boot - Extra Module Packages
    # https://search.nixos.org/options?channel=unstable&show=boot.extraModulePackages
    extraModulePackages = [];

    # Boot - Kernel Params
    # https://search.nixos.org/options?channel=unstable&show=boot.kernelParams
    kernelParams = [ 
      "amdgpu.dcdebugmask=0x10"
      "splash"
      "quiet"
      "udev.log_level=3"
      "amd_pstate=active"
    ];

    # Boot - Console Logging Level
    # https://search.nixos.org/options?channel=unstable&show=boot.consoleLogLevel
    consoleLogLevel = 0;

    # Boot - Temporary Directory
    # https://search.nixos.org/options?channel=unstable&show=boot.tmp
    tmp = {
      # Boot - Temporary Directory - Clean On Boot
      # https://search.nixos.org/options?channel=unstable&show=boot.tmp.cleanOnBoot
      cleanOnBoot = lib.mkDefault true;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  # Hardware
  # https://search.nixos.org/options?channel=unstable&show=hardware
  hardware = {
    pulseaudio.enable = false;
    # Hardware - Enable all the firmware with a license allowing redistribution.
    # https://search.nixos.org/options?channel=unstable&show=hardware.enableRedistributableFirmware
    enableRedistributableFirmware = lib.mkDefault true;

    # Hardware - CPU - AMD Microcode
    # https://search.nixos.org/options?channel=unstable&show=hardware.cpu.amd.updateMicrocode
    cpu.amd.updateMicrocode = lib.mkDefault true;

    # Hardware - Bluetooth
    # https://search.nixos.org/options?channel=unstable&show=hardware.bluetooth

    # Hardware - OpenGL
    # https://search.nixos.org/options?channel=unstable&show=hardware.opengl
    opengl = {

      # OpenGL - Enable
      # https://search.nixos.org/options?channel=unstable&show=hardware.opengl.enable
      enable = lib.mkDefault true;

      # Hardware - OpenGL - Enable accelerated OpenGL rendering through the Direct Rendering Interface (DRI)
      # https://search.nixos.org/options?channel=unstable&show=hardware.opengl.driSupport
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;

      # Hardware - OpenGL - Additional packages to add to OpenGL drivers.
      # https://search.nixos.org/options?channel=unstable&show=hardware.opengl.extraPackages
      extraPackages = with pkgs; [
        glxinfo
        rocm-opencl-icd
        rocm-opencl-runtime
        libva
        libva-utils
      ];

      # Hardware - OpenGL - Additional packages to add to 32-bit OpenGL drivers on 64-bit systems.
      # https://search.nixos.org/options?channel=unstable&show=hardware.opengl.extraPackages32
      # https://search.nixos.org/packages?channel=unstable&show=driversi686Linux
      extraPackages32 = with pkgs.driversi686Linux; [
        glxinfo
      ];
    };

  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0f4u1u1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
