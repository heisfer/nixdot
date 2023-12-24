{
  inputs,
  withSystem,
  self,
  homeImports,
  sharedModules,
  ...
}: {
  flake.nixosConfigurations = withSystem "x86_64-linux" ({
    system,
    self',
    ...
  }: {
    voyage = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs self';
      };
      modules =
        [
          ./voyage
          self.nixosModules.greetd
          self.nixosModules.bluetooth
          {home-manager.users.heisfer.imports = homeImports."heisfer@voyage";}
        ]
        ++ sharedModules;
    };
  });
}
