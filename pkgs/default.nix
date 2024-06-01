{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        rose-pine-gtk = pkgs.callPackage ./rose-pine-gtk { };
        blade-formatter = pkgs.callPackage ./blade-formatter { };
        beekeeper-studio = pkgs.callPackage ./beekeeper-studio { };
        tableplus = pkgs.callPackage ./tableplus { };
        laravel = pkgs.callPackage ./laravel { };
        clickup = pkgs.callPackage ./clickup { };
      };
    };
}
