{ inputs, self, ... }: {
  imports = [
    inputs.pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem = {
    pkgsDirectory = "${self}/pkgs/";
  };
}
