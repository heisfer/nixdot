{ inputs, ... }:
{
  perSystem =
    { self', system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ (_: _: { local = self'.packages; }) ];
      };
    };
}
