{ inputs, ... }:
{
  # Local Pkgs
  local-packages = final: _prev: {
    local = import ./../pkgs final.pkgs;
  };

  # nixpkgs-unstable-small
  small = final: _prev: {
    small = import inputs.nixpkgs-small {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
