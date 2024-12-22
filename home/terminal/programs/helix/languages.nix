{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    python312Packages.python-lsp-server
  ];
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
      {
        name = "python";
        formatter = {
          command = lib.getExe pkgs.black;
          args = [
            "-"
            "--quiet"
            "--line-length 100"
          ];
        };
        auto-format = true;
      }
    ];
  };
}
