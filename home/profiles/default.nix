{
  self,
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.
    ../shell
    module_args
    inputs.hyprland.homeManagerModules.default
    inputs.ags.homeManagerModules.default
  ];
  homeImports = {
    "heisfer@voyage" = [./voyage] ++ sharedModules;
  };
  inherit (inputs.hm.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];
  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
      "heisfer@voyage" = homeManagerConfiguration {
        modules = homeImports."heisfer@voyage";
        inherit pkgs;
      };
    });
  };
}
