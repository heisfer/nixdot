{ self, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.helix
  ];

  networking.hostName = "azazel";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.trusted-users = [ "admin" ];

  programs.zsh.enable = true;
  porgrams.zoxide.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  users.users.admin = {
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrm0EUxny2HElfT47FpyVcYssDxgO9ZjEzqU/2S820b heisfer@voyage"
      ];
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
