{
  withSystem,
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations = {
    voyage = withSystem "x86_64-linux" (
      {
        # inputs',
        # config,
        self',
        ...
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs self';
        };
        modules = [
          ./voyage
          self.nixosModules.ath11k
          self.nixosModules.polkit-gnome
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.heisfer = import ../home;
              extraSpecialArgs = {
                inherit inputs self' self;
              };
            };
          }
        ];
      }
    );
  };
}
