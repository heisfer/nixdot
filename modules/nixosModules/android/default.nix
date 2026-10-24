{
  flake.nixosModules.android = { pkgs, ... }: {
    virtualisation.waydroid.enable = true;
    virtualisation.waydroid.package = pkgs.waydroid-nftables;
    environment.systemPackages = [ pkgs.wl-clipboard ];
  };
}
