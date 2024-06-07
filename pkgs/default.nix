{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        rose-pine-gtk-theme = pkgs.callPackage ./rose-pine-gtk-theme { };
        blade-formatter = pkgs.callPackage ./blade-formatter { };
        beekeeper-studio = pkgs.callPackage ./beekeeper-studio { };
        tableplus = pkgs.callPackage ./tableplus { };
        zoho-mail-desktop-lite = pkgs.callPackage ./zoho-mail-desktop-lite { };
      };
    };
}
