{ inputs, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.systemPackages = [
    inputs.lightly.packages.${pkgs.system}.darkly-qt5
    inputs.lightly.packages.${pkgs.system}.darkly-qt6
  ];
}
