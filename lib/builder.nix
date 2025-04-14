{ lib }:
# Full credit goes to wolfgang
let
  systems = [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
in
{
  mkSystem =
    {
      hostname,
      extraModules,
      specialArgs,
      overlays,
    }:
    {
      nixosConfigurations.${hostname} = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ../systems/${hostname}
          {
            networking.hostName = hostname;
            nixpkgs.overlays = overlays;
          }
        ] ++ extraModules;
      };

    };

  mkMerge = lib.lists.foldl' (a: b: lib.attrsets.recursiveUpdate a b) { };
  forAllSystems = lib.genAttrs systems;
}
