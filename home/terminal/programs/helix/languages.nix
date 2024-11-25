{ lib, pkgs, ... }:
{
  programs.helix.languages = {
    language-server = {
      nixd = {
        command = lib.getExe pkgs.nixd;
        config.nixd = {
          formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
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
