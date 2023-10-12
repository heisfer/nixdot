{ inputs, system, extraArgs, ... }:
with inputs; let
  hmModule = inputs.home-manager.nixosModules.home-manager;
  hyprlandModule = inputs.hyprland.homeManagerModules.default;
  inherit (inputs.nixpkgs.lib) nixosSystem;
  kmonadModule = inputs.kmonad.nixosModules.default;
in {
  thinkchan = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ./thinkchan
      inputs.kmonad.nixosModules.default
      hmModule
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs extraArgs ;};
          users.heisfer = {
            imports = [
              ../home/profiles/thinkchan.nix
              hyprlandModule
            ];
          };
        };
      }
    ];
  };
}
