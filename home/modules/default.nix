{ self, ... }:
{
  flake.homeManagerModules = {
    vesktop = import ./programs/vesktop;
    default = self.homeManagerModules.vesktop; # figure me out later
  };
}
