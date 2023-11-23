{pkgs}: {
  miru = pkgs.callPackage ./miru {};
  wezterm = pkgs.callPackage ./wezterm {};
  wavebox = pkgs.callPackage ./wavebox {};
  spacedrive = pkgs.callPackage ./spacedrive {};
}
