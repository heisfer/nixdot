{
  inputs,
  self,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.home-manager.nixosModules) home-manager;
  ylib = inputs.nypkgs.lib."x86_64-linux";
in
{
  flake.nixosConfigurations = {
    voyage = nixosSystem {
      specialArgs = {
        inherit inputs ylib;
      };
      modules = [
        ./voyage
        inputs.dotmod.nixosModules.swayosd
        inputs.hyprland.nixosModules.default
        home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.heisfer = import ../home;
          home-manager.extraSpecialArgs = {
            inherit inputs ylib;
          };
        }

      ];
    };
  };
}
