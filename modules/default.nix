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
          # inputs.kmonad.nixosModules.default
          inputs.lanzaboote.nixosModules.lanzaboote
					inputs.nix-minecraft.nixosModules.minecraft-servers
          module_args
          self.nixosModules.desktop
					self.nixosModules.minecraft
        ];
      };
    }
  ];

  flake.nixosModules = {
    greetd = import ./greetd.nix;
    lanzaboote = import ./lanzaboote.nix;
		minecraft = import ./minecraft;

    desktop = import ./desktop.nix;
    bluetooth = import ./bluetooth.nix;
  };
}
