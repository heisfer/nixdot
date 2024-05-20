{
  perSystem =
    { pkgs, system, ... }:
    {
      packages = {
        rose-pine-gtk = pkgs.callPackage ./rose-pine-gtk { };
        blade-formatter = pkgs.callPackage ./blade-formatter { inherit system; };
      };
    };
}
