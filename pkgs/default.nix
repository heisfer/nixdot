{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        rose-pine-gtk-theme = pkgs.callPackage ./rose-pine-gtk-theme { };
        blade-formatter = pkgs.callPackage ./blade-formatter { };
        beekeeper-studio = pkgs.callPackage ./beekeeper-studio { };
        tableplus = pkgs.callPackage ./tableplus { };
        zoho-mail-desktop = pkgs.callPackage ./zoho-mail-desktop { };
        simple-completion-language-server = pkgs.callPackage ./simple-completion-language-server { };
      };
    };
}
