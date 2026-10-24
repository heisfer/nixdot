{ self, inputs, ... }:
{
  perSystem =
    {
      inputs',
      system,
      lib,
      ...
    }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;

      eval = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.nixosModules.losfelt
          { nixpkgs.hostPlatform = system; }
        ];
      };

      optionsDoc = pkgs.nixosOptionsDoc {
        options = { inherit (eval.options) losfelt; };
        warningsAreErrors = false;

        transformOptions =
          opt:
          opt
          // {
            declarations = map (
              d:
              let
                p = toString d;
                root = "${toString self}/";
              in
              if lib.hasPrefix root p then lib.removePrefix root p else p
            ) opt.declarations;
          };
      };
    in
    {
      packages.docs = optionsDoc.optionsCommonMark;
    };
}
