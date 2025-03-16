{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers = {
      vanilla-server = {
        enable = true;
        autoStart = false;
        package = pkgs.vanillaServers.vanilla-1_12;
      };
      geyser-server = {
        enable = true;
        autoStart = false;
        package = pkgs.geyser-server;
      };
    };

  };
}
