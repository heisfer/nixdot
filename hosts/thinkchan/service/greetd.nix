{pkgs, lib, inputs, config, ...}: let
  hyprlandConf = pkgs.writeText "hyprland" ''
    exec-once = ${lib.getExe config.programs.regreet.package} -l debug; hyprctl dispatch exit
  '';
in {
  programs.hyprland.package = inputs.hyprland.packages."x86_64-linux".default;
  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet.overrideAttrs (self: super: {
      version = "0.1.1-patched";
      src = pkgs.fetchFromGitHub {
        owner = "rharish101";
        repo = "ReGreet";
        rev = "61d871a0ee5c74230dfef8100d0c9bc75b309203";
        hash = "sha256-PkQTubSm/FN3FXs9vBB3FI4dXbQhv/7fS1rXkVsTAAs=";
      };
      cargoDeps = super.cargoDeps.overrideAttrs (_: {
        inherit (self) src;
        outputHash = "sha256-dR6veXCGVMr5TbCvP0EqyQKTG2XM65VHF9U2nRWyzfA=";
      });

      # temp fix until https://github.com/rharish101/ReGreet/issues/32 is solved
      patches = [./regreet.patch];
    });
  };
  services.greetd = {
    enable = true;
    #    package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
        command = "${lib.getExe config.programs.hyprland.package} --config ${hyprlandConf}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
    bash
  '';
}
