{ lib, pkgs, ... }:
{
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = lib.getExe pkgs.nixd;
        config.nixd = {
          formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
          options = {
            home-manager.expr = "(builtins.getFlake \"/home/heisfer/Projects/nix/dots\").homeConfigurations.\"heisfer@voyage\".options";
          };
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
