{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      miru = pkgs.callPackage ./miru {};
      wezterm = pkgs.callPackage ./wezterm {};
    };
  };
}
