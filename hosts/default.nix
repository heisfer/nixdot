{
  inputs,
  system,
  extraArgs,
  ...
}:
with inputs; let
  hmModule = home-manager.nixosModules.home-manager;
  hyprlandModule = hyprland.homeManagerModules.default;
  inherit (nixpkgs.lib) nixosSystem;
in {
  thinkchan = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ./thinkchan
      inputs.kmonad.nixosModules.default
      inputs.xremap-flake.nixosModules.default
      hmModule
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs extraArgs;};
          users.heisfer = {
            imports = [
              ../home/profiles/thinkchan/default.nix
              hyprlandModule
            ];
          };
        };
      }
    ];
  };
}
