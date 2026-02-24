{
  #vm doesn't read hwconfig
  virtualisation.vmVariantWithDisko = {
    # to set virtualisation image size
    disko.devices.disk.main.imageSize = "8G";
    virtualisation = {
      # Needed for Disko VM
      fileSystems."/persist".neededForBoot = true;

      # idk
      qemu.options = [
        "-device virtio-vga-gl"
        "-display sdl,gl=on,show-cursor=off"
      ];

    };

  };
}
