{
  flake.nixosModules = {
    ath11k = import ./services/ath11k.nix;
    polkit-gnome = import ./services/polkit-gnome.nix;
    swayosd-inputs = import ./services/swayosd-inputs.nix;
  };
}
