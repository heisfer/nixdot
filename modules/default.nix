{
  self,
  inputs,
  default,
  ...
}: let
  # system-agnostic args
  module_args._module.args = {
    inherit default inputs self;
  };
in {
  imports = [
    {
      _module.args = {
        # we need to pass this to HM
        inherit module_args;

        # NixOS modules
        sharedModules = [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }

          inputs.home-manager.nixosModule
          inputs.hyprland.nixosModules.default
          inputs.kmonad.nixosModules.default
          module_args
          self.nixosModules.desktop
        ];
      };
    }
  ];

  flake.nixosModules = {
    greetd = import ./greetd.nix;

    desktop = import ./desktop.nix;
    bluetooth = import ./bluetooth.nix;
  };
}
