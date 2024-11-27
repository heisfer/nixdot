{ lib, pkgs, ... }:
{
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = lib.getExe pkgs.nixd;
        config.nixd = {
          formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
          options = {
            home-manager.expr = "(builtins.getFlake \"/home/heisfer/Projects/nix/dots\").nixosConfigurations.voyage.config.home-manager.users.heisfer";
          };
        };
        zls = {
          command = lib.getExe pkgs.zls;
        };
      };
    };
    language = [
      {
        name = "nix";
        language-servers = [
          "nixd"
        ];
        auto-format = true;
      }
    ];
  };
}
