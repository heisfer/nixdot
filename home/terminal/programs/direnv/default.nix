{ config, ... }:
{
  programs.direnv = {
    enable = true;
    enableNushellIntegration = config.programs.nushell.enable;
    enableBashIntegration = config.programs.bash.enable;
  };
}
