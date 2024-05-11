{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs.helix = {
    languages = {
      language-server = {
        nil = {
          command = "${lib.getExe inputs.nil.packages.${pkgs.system}.default}";
          config.nil.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
        };
      };
      language = [
        {
          name = "nix";
          language-servers = [ "nil" ];
          scope = "source.nix";
          injection-regex = "nix";
          auto-format = true;
          file-types = [ "nix" ];
          comment-token = "#";
        }
      ];
    };
  };
}
