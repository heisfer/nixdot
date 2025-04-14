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

  # ssh darwin
  programs.ssh.extraConfig = ''
    Host azazel
        HostName localhost
        User admin
        Port 2222
        IdentityFile ~/.ssh/darwin
  '';

  # Broken experimental code
  # nix.distributedBuilds = true;
  # nix.buildMachines = [
  #   {
  #     hostname = "azazel";
  #     system = "x86_64-darwin";
  #     protocol = "ssh-ng";
  #   }
  # ];

  # For VNC
  environment.systemPackages = [ pkgs.remmina ];
}
