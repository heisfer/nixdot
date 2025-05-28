{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) genAttrs;
  cfg = config.programs.direnv;

  tomlFormat = pkgs.formats.toml { };
in

{
  options.programs.direnv.config = mkOption {
    type = tomlFormat.type;
    default = { };
    description = "REF Manual: https://direnv.net/man/direnv.toml.1.html";
    example = {
      whitelist.prefix = [
        # To auto enable all .envrc in nix directory
        "~/Projects/nix"
      ];
    };
  };

  config = mkIf cfg.enable {
    hjem.users = genAttrs config.userspace.hjemUsers (user: {
      files.".config/direnv/direnv.toml" = mkIf (cfg.config != { }) {
        source = tomlFormat.generate "direnv-config" cfg.config;
      };
    });
  };
}
