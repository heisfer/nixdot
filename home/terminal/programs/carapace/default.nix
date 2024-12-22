{ config, ... }:
{
  programs.carapace = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;
  };
}
