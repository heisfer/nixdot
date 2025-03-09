{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options)
    mkEnableOption
    mkPackageOption
    mkOption
    ;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe';
  inherit (lib.types) listOf str;
  inherit (lib.strings) concatStringsSep;

  cfg = config.programs.zoxide;

  cfgOptions = concatStringsSep " " cfg.options;
  enabledOption =
    x:
    mkEnableOption x
    // {
      default = true;
      example = false;
    };

in
{
  options.programs.zoxide = {
    enable = mkEnableOption "zoxide";
    package = mkPackageOption pkgs "zoxide" { };

    enableBashIntegration = enabledOption ''
      Bash integration
    '';
    enableZshIntegration = enabledOption ''
      Zsh integration
    '';
    enableFishIntegration = enabledOption ''
      Fish integration
    '';
    enableXonshIntegration = enabledOption ''
      Xonsh integration
    '';

    options = mkOption {
      type = listOf str;
      default = [ ];
      example = [ "--no-cmd" ];
      description = ''
        List of options to pass to zoxide init.
      '';
    };

  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    programs = {
      zsh.interactiveShellInit = mkIf cfg.enableZshIntegration ''
        eval "$(${getExe' cfg.package "zoxide"} init zsh ${cfgOptions} )"
      '';
      bash.interactiveShellInit = mkIf cfg.enableBashIntegration ''
        eval "$(${getExe' cfg.package "zoxide"} init bash ${cfgOptions} )"
      '';
      fish.interactiveShellInit = mkIf cfg.enableFishIntegration ''
        ${getExe' cfg.package "zoxide"} init fish ${cfgOptions} | source
      '';
      xonsh.config = ''
        execx($(${getExe' cfg.package "zoxide"} init xonsh ${cfgOptions}), 'exec', __xonsh__.ctx, filename='zoxide')
      '';
    };

  };

}
