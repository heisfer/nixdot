{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  cfg = config.programs.zellij;
in
{
  options.programs.zellij = {
    enable = mkEnableOption "zellij";

    package = mkPackageOption pkgs "zellij" { };

    enableBashIntegration = mkEnableOption "Bash integration";
    enableZshIntegration = mkEnableOption "Zsh integration";
    enableFishIntegration = mkEnableOption "Fish integration";

  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    #Auto start
    programs = {
      bash.interactiveShellInit = mkIf cfg.enableBashIntegration ''
        eval "$(${getExe cfg.package} setup --generate-auto-start bash)"
      '';
      zsh.interactiveShellInit = mkIf cfg.enableZshIntegration ''
        eval "$(${getExe cfg.package} setup --generate-auto-start zsh)"
      '';
      fish.interactiveShellInit = mkIf cfg.enableFishIntegration ''
        eval (${getExe cfg.package} setup --generate-auto-start fish | string collect)
      '';
    };
  };

}
