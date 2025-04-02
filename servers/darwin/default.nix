{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixtheplanet.nixosModules.macos-ventura ];

  services.macos-ventura = {
    enable = true;
    # vncListenAddr = "0.0.0.0";
    cores = 4;
    threads = 8;
    mem = "8G";
    autoStart = false;
  };

  # For VNC
  environment.systemPackages = [ pkgs.remmina ];
}
