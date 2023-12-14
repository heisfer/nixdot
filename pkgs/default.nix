{pkgs}: {
  miru = pkgs.callPackage ./miru {};
  wezterm = pkgs.callPackage ./wezterm {};
  wavebox = pkgs.callPackage ./wavebox {};
  spacedrive = pkgs.callPackage ./spacedrive {};
  sigmafm = pkgs.callPackage ./sigmafm {};
  swaylock-fprintd = pkgs.callPackage ./swaylock-fprintd {};
}
