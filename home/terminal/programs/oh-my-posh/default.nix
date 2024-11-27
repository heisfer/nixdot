{ config, ... }:
{
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;

  };
}
